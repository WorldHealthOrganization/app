# Load Balancer

terraform {
  required_version = ">= 0.13"
}


# IPv4 Public Address
# TODO: add IPv6 AAAA record as alternative
resource "google_compute_global_address" "ipv4" {
  project      = var.project_id
  name         = "${var.name}-address"
  ip_version   = "IPV4"
  address_type = "EXTERNAL"
  lifecycle {
    prevent_destroy = true
  }
}


# Http
# TODO: redirect to https
resource "google_compute_target_http_proxy" "http-proxy" {
  count   = var.enable_http ? 1 : 0
  project = var.project_id
  name    = "${var.name}-http-proxy"
  url_map = var.url_map
}

resource "google_compute_global_forwarding_rule" "http-rule" {
  provider   = google-beta
  count      = var.enable_http ? 1 : 0
  project    = var.project_id
  name       = "${var.name}-http-rule"
  target     = google_compute_target_http_proxy.http-proxy[0].self_link
  ip_address = google_compute_global_address.ipv4.address
  port_range = "80"

  depends_on = [google_compute_global_address.ipv4]
}


# Https
resource "google_compute_target_https_proxy" "https-proxy" {
  provider         = google-beta
  count            = 1
  name             = "${var.name}-https-proxy"
  url_map          = var.url_map
  ssl_certificates = [google_compute_managed_ssl_certificate.ssl-cert.id]
  ssl_policy       = google_compute_ssl_policy.ssl-policy.self_link
}

resource "google_compute_ssl_policy" "ssl-policy" {
  name            = "${var.name}-ssl-policy"
  min_tls_version = "TLS_1_2"
  profile         = "MODERN"
  # https://cloud.google.com/load-balancing/docs/ssl-policies-concepts#defining_an_ssl_policy
}

resource "google_compute_global_forwarding_rule" "https-rule" {
  provider   = google-beta
  project    = var.project_id
  count      = 1
  name       = "${var.name}-https-rule"
  target     = google_compute_target_https_proxy.https-proxy[0].self_link
  ip_address = google_compute_global_address.ipv4.address
  port_range = "443" # https port
  depends_on = [google_compute_global_address.ipv4]
}

resource "random_id" "certificate" {
  byte_length = 4

  keepers = {
    domains = var.domain
  }
}

resource "google_compute_managed_ssl_certificate" "ssl-cert" {
  provider = google-beta

  # Must change name when editing as Google provider doesn't support update in
  # place. Also need to create replacement resource before deleting old resource.
  # `terraform apply` must be done twice. 1st error: resourceInUseByAnotherResource
  name = "${var.name}-ssl-cert-${random_id.certificate.hex}"
  lifecycle {
    create_before_destroy = true
  }

  managed {
    domains = [var.domain]
  }
}


# DNS Records
# TODO: doesn't work => https://github.com/WorldHealthOrganization/app/issues/1723
resource "google_dns_record_set" "dns" {
  project = var.project_id
  count   = var.create_dns_entries ? 1 : 0

  name = "${var.domain}."
  type = "A"
  ttl  = var.dns_record_ttl

  managed_zone = google_dns_managed_zone.dns-managed-zone.name

  rrdatas = [google_compute_global_address.ipv4.address]
}

resource "google_dns_managed_zone" "dns-managed-zone" {
  name     = "${var.name}-dns-managed-zone"
  dns_name = "${var.domain}."
}
