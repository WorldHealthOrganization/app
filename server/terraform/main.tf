# DO NOT APPLY
# instead apply individual projects

# Listing out all projects allows the following commands to work
# in the top folder and update all resource below recursively:
#
# terraform init
# terraform validate .

module "hack" {
  source = "./hack"
}

# TODO: prod, staging
