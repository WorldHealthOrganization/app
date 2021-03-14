# v2-dev1 - experimental (unstable) environment, no privacy expectation

module "myhealth" {
  source     = "../modules/myhealth"
  project_id = "who-mh-v2-dev1"
  domain     = null

  # Use a v2 backend.
  backend_version = "v2"
}
