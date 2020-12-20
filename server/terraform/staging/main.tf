# staging - default development server, no privacy expectation

module "myhealth" {
  source     = "../modules/myhealth"
  project_id = "who-mh-staging"
  domain     = "staging.whocoronavirus.org"
}
