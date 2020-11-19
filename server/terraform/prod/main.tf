# Production - public production service, strong privacy applies

module "myhealth" {
  source     = "../modules/myhealth"
  project_id = "who-mh-prod"
  domain     = "covid19app.who.int"

  # Production Terraform service account doesn't have permission for project
  # creation or DNS config, so skip these steps. This is done manually by WHO.
  create_project   = false
  create_dns_entry = false
}
