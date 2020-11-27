# MyHealth Service
#
# App Engine
# Firebase
# Networking
# Https Load Balancer
# DNS Entry

terraform {
  required_version = ">= 0.13"
}

locals {
  # We want the storage bucket to be multi-region. Lookup the location for that
  # using var.region prefix; falls back to var.region. Based on current list:
  # https://cloud.google.com/storage/docs/locations
  storage_location_prefixes = {
    "EUROPE" = "EU",
    "US"     = "US",
    "ASIA"   = "ASIA"
  }
  storage_bucket_location = lookup(local.storage_location_prefixes,
  upper(split("-", var.region)[0]), var.region)
}

provider "google" {
  version = "~> 3.46.0"
  region  = var.region
  project = var.project_id
}

provider "google-beta" {
  version = "~> 3.37.0"
  region  = var.region
  project = var.project_id
}

# Pin Hashicorp Dependencies
provider "external" {
  version = "~> 2.0.0"
}

provider "null" {
  version = "~> 3.0.0"
}

provider "random" {
  version = "~> 3.0.0"
}

# Google Project
resource "google_project" "project" {
  provider        = google-beta
  count           = var.create_project ? 1 : 0
  name            = var.project_id
  project_id      = var.project_id
  billing_account = var.billing_account
  org_id          = var.org_id
  lifecycle {
    prevent_destroy = true
  }
}

# Do `depends_on` this resource iff it requires APIs to be enabled
resource "google_project_service" "service" {
  for_each = toset([
    "appengine.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "compute.googleapis.com",
    "dns.googleapis.com",
    "firebase.googleapis.com",
  ])

  service            = each.key
  project            = var.project_id
  disable_on_destroy = false
  depends_on         = [google_project.project]
}


# Firebase
resource "google_firebase_project" "firebase" {
  provider   = google-beta
  project    = var.project_id
  depends_on = [google_project_service.service]
  # TODO: protect data
  lifecycle {
    prevent_destroy = true
  }
}

resource "google_firebase_project_location" "fireloc" {
  provider    = google-beta
  project     = var.project_id
  location_id = var.region
  depends_on  = [google_firebase_project.firebase]
}


# App Engine
resource "google_app_engine_application" "gae" {
  project       = var.project_id
  location_id   = var.region
  database_type = "CLOUD_DATASTORE_COMPATIBILITY"
  depends_on    = [google_project_service.service]
  # TODO: protect resource as it can't be recreated after being destroyed
  lifecycle {
    prevent_destroy = true
  }
}


# Logging Configuration: Ensure logs go to a regionalized location.
# See: https://cloud.google.com/logging/docs/regionalized-logs
#
# Logging Configuration 1/2: Bucket in regional location.
# Note: Requires logging.admin or cloud-platform permissions for
# terraform service account.
resource "google_logging_project_bucket_config" "regional_log_bucket" {
  project        = var.project_id # google_project.project.name
  location       = var.logs_region
  retention_days = 30
  bucket_id      = "${var.logs_region}-logs-bucket"
  depends_on     = [google_project_service.service]
}


# Logging Configuration 2/2: Set default sink to regional bucket.
# Redirects App Engine and other non-audit logs to a regional bucket.
#
# Note: Terraform does not currently handle _Default buckets well. It will fail
# on the first apply; you must then 'import' the sink into the tf state with:
# terraform import module.myhealth.google_logging_project_sink.default projects/${var.project_id}/sinks/_Default
# See: https://github.com/hashicorp/terraform-provider-google/issues/7811
resource "google_logging_project_sink" "default" {
  name = "_Default"

  destination = join("",
    ["logging.googleapis.com/",
    google_logging_project_bucket_config.regional_log_bucket.id]
  )

  unique_writer_identity = true

  # While this is the default filter, it must be re-set explicitly.
  filter = <<-endfilter
    NOT LOG_ID("cloudaudit.googleapis.com/activity") AND
    NOT LOG_ID("externalaudit.googleapis.com/activity") AND
    NOT LOG_ID("cloudaudit.googleapis.com/system_event") AND
    NOT LOG_ID("externalaudit.googleapis.com/system_event") AND
    NOT LOG_ID("cloudaudit.googleapis.com/access_transparency") AND
    NOT LOG_ID("externalaudit.googleapis.com/access_transparency")
  endfilter

  depends_on = [google_logging_project_bucket_config.regional_log_bucket]
}


# Load Balancer
module "lb" {
  source             = "../http-load-balancer"
  project_id         = var.project_id
  name               = "${var.project_id}-lb"
  url_map            = google_compute_url_map.urlmap.self_link
  create_dns_entries = var.create_dns_entry
  dns_record_ttl     = var.dns_record_ttl
  domain             = var.domain
  enable_http        = false
  depends_on         = [google_project_service.service]
}


# Url Map to map paths to backends
resource "google_compute_url_map" "urlmap" {
  project         = var.project_id
  name            = "${var.project_id}-url-map"
  description     = "URL map for ${var.project_id}"
  default_service = google_compute_backend_service.backend.self_link
  host_rule {
    hosts        = ["*"]
    path_matcher = "all"
  }
  path_matcher {
    name            = "all"
    default_service = google_compute_backend_service.backend.self_link
    path_rule {
      paths   = ["/content/*"]
      service = google_compute_backend_bucket.content.id
    }

  }
  depends_on = [google_project.project]
}


# Network Endpoint Group and App Engine Backend
resource "google_compute_region_network_endpoint_group" "neg" {
  provider              = google-beta
  name                  = "${var.project_id}-neg-appengine"
  network_endpoint_type = "SERVERLESS"
  region                = var.region
  //noinspection HCLUnknownBlockType: app_engine
  app_engine {
    service = "default"
  }
  depends_on = [google_project_service.service]
}


# Google Cloud Armor security policy.
resource "google_compute_security_policy" "policy" {
  name = "lb-security-policy"

  # IP Block list. 
  # Up to ten IP ranges can be created per rule.
  # Each rule is identified by its priority, from 1=highest to maxint32=default.
  rule {
    action   = "deny(403)"
    priority = "1000"
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        # Using an unused portion of the loopback block as a placeholder.
        # Remove it once a real set of IP Ranges are present.
        src_ip_ranges = ["127.0.0.255/32", "127.0.0.254"]
      }
    }
    description = "Deny access to specified IPs"
  }

  # The default rule at maxint32. Should not need to be changed.
  rule {
    action   = "allow"
    priority = "2147483647"
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = ["*"]
      }
    }
    description = "default rule"
  }

  # In case this resource is renamed in Terraform, the lifecycle must be:
  #  1: Create new policy 
  #  2: Configure backend to reference it
  #  3: Delete old policy.
  # To accomplish this, it is set to create_before_destroy, 
  # then running apply twice completes the operation.
  lifecycle {
    create_before_destroy = true
  }
}


resource "google_compute_backend_service" "backend" {
  name                            = "${var.project_id}-backend-appengine"
  load_balancing_scheme           = "EXTERNAL"
  protocol                        = "HTTPS"
  session_affinity                = "CLIENT_IP"
  connection_draining_timeout_sec = 60
  enable_cdn                      = true
  cdn_policy {
    signed_url_cache_max_age_sec = 3600
  }
  security_policy = google_compute_security_policy.policy.id
  backend {
    capacity_scaler = 1
    group           = google_compute_region_network_endpoint_group.neg.id
  }
  # TODO: figure out what health checks are possible
  health_checks = null
  depends_on    = [google_project.project]
}


# Google Cloud bucket for static content assets.
resource "google_storage_bucket" "content" {
  # While the bucket name is in a flat global namespace, this pattern has 
  # been available so far for all appids in use.
  name     = "${var.project_id}-static-content"
  location = local.storage_bucket_location

  # There should be no need for per-object ACLs with this bucket.
  uniform_bucket_level_access = true

  # Prevent Terraform from destroying the bucket if any content is present.
  force_destroy = false
}

# Object are all world-readable. Set using the simplest mechanism.
resource "google_storage_bucket_iam_binding" "binding" {
  bucket = google_storage_bucket.content.name
  role   = "roles/storage.objectViewer"
  members = [
    "allUsers",
  ]
  depends_on = [google_storage_bucket.content]
}

# Routing
resource "google_compute_backend_bucket" "content" {
  name        = "static-content-backend-bucket"
  bucket_name = google_storage_bucket.content.name
  enable_cdn  = true
}
