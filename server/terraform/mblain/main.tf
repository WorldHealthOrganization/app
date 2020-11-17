# MBlain's test setup
# instead apply individual projects

# Listing out all projects allows the following commands to work
# in the top folder and update all resource below recursively:
#
# terraform init
# terraform validate .

module "myhealth" {
  source     = "../modules/myhealth"
  project_id = "mblain-13nov2020"
  domain     = "mblain-13nov2020.appspot.com"  # Will this work?
  
  org_id = ""
  billing_account = ""

  # Since this service account cannot create the project, I'll re-use  the 'prod-like' settings.
  # I don't understand why Terraform can't 'look up' that the project was created.
  create_project   = false
  create_dns_entry = false
}
