# v2-dev1 - experimental (unstable) environment, no privacy expectation

module "myhealth" {
  source     = "../modules/myhealth-v2"
  project_id = "who-mh2-dev1"
  domain     = null
}
