# staging - default development server, no privacy expectation

module "myhealth" {
  source     = "../modules/myhealth"
  project_id = "who-mh-staging"
  # TODO: migrate to staging.whocoronavirus.org
  domain = "staging-temp.whocoronavirus.org"
}
