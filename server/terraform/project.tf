variable "project_id" {
  type = string
}
variable "billing_account" {
  type = string
}
variable "location_id" {
  type = string
}
variable "org_id" {
  type = string
}

provider "google" {
  region = var.location_id
}

resource "google_project" "project" {
  provider        = google-beta
  name            = var.project_id
  project_id      = var.project_id
  billing_account = var.billing_account
  org_id          = var.org_id
}

resource "google_firebase_project" "default" {
  provider = google-beta
  project  = google_project.project.project_id
}

resource "google_firebase_project_location" "basic" {
  provider    = google-beta
  project     = google_firebase_project.default.project
  location_id = var.location_id
}

resource "google_app_engine_application" "app" {
  project       = google_firebase_project.default.project
  location_id   = var.location_id
  database_type = "CLOUD_DATASTORE_COMPATIBILITY"
}
