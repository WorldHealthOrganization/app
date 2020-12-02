# MyHealth Variables

# Required fields
variable "project_id" {
  type = string
}

variable "domain" {
  description = "Custom domain name. E.g. staging.whocoronavirus.org"
  type        = string
}

# World Health Organization policy is to locate data in Switzerland if possible
# "europe-west6" is Google's Zurich region and has 3 zones for redundancy
# https://cloud.google.com/compute/docs/regions-zones
variable "region" {
  type    = string
  default = "europe-west6" # Switzerland
}

# Regionalized Logs available in limited regions, so may vary from "region" variable
variable "logs_region" {
  type = string
  # TODO: move to Switzerland when technically possible
  # https://github.com/WorldHealthOrganization/app/issues/1754
  # TODO: remove variable once Regionalized Logs is universally available
  default = "europe-west1" # Belgium
}

# whocoronavirus.org development accounts used by default
variable "billing_account" {
  type    = string
  default = "012022-BA7D8D-292EE8"
}
variable "org_id" {
  type    = string
  default = "532343229286"
}

# Create project: requires special permissions:
# https://github.com/WorldHealthOrganization/app/blob/master/server/terraform/README.md#terraform-service-account
variable "create_project" {
  description = "Create Project. Set to false when using existing project."
  type        = bool
  default     = true
}

variable "create_dns_entry" {
  description = "Create a DNS A Record in Cloud DNS for the domain specified in 'domain'."
  type        = bool
  default     = true
}

variable "dns_record_ttl" {
  description = "The time-to-live for the load balancer A record (seconds)"
  type        = string
  default     = 3600
}
