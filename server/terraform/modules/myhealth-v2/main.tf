# MyHealth Service

terraform {
  required_version = ">= 0.13"
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
    "firebasehosting.googleapis.com",
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


# App Engine - required to create the Firestore database.
#   See: https://firebase.google.com/docs/firestore/solutions/automate-database-create#create_a_database_with_terraform
#   NOTE: contrary to this documentation, we seem to still need a manual step to actually create the Firestore database.
#         That manual step is documented in `server/terraform/README.md`.
resource "google_app_engine_application" "gae" {
  project       = var.project_id
  location_id   = var.region
  database_type = "CLOUD_FIRESTORE"
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

