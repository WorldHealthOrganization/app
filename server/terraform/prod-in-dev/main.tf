# Production in Dev - testing production permissions, no privacy expectation

# Replicates Production permissions which are more limited than development:
# https://github.com/WorldHealthOrganization/app/blob/master/server/terraform/README.md#terraform-service-account

module "myhealth" {
  source     = "../modules/myhealth"
  project_id = "who-mh-prod-in-dev"
  domain     = "prod-in-dev.whocoronavirus.org"

  # Matches configuration of prod/main.tf
  create_project   = false
  create_dns_entry = false
}
