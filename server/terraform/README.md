## How to create and setup GCP projects using terraform

### Prerequisites

- [Install Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/gcp-get-started)
- Make sure you have access to `who-terraform-admin` project.
- Create a new key
  - Visit: https://console.cloud.google.com/apis/credentials/serviceaccountkey?project=who-terraform-admin&organizationId=532343229286
  - Service Account: select "Terraform"
  - Click "Create", download file and configure environment:

```sh
export GOOGLE_APPLICATION_CREDENTIALS=<path to json credentials>
```

This uses the `terraform@who-terraform-admin.iam.gserviceaccount.com` service account in the `who-terraform-admin` project.

### External Documentation

- [Terraform adding credentials](https://www.terraform.io/docs/providers/google/guides/getting_started.html#adding-credentials)
- [Securely handling keys](https://cloud.google.com/iam/docs/understanding-service-accounts?_ga=2.87249435.-2051693357.1581897767#managing_service_account_keys)

### Terraform service account

Only needed for terraform service account setup. The account must have these permissions:

- Billing Account User
- Project Creator

### Create / update GCP project

The `apply` can be used to both create and update the server config.

```sh
# setup
cd server/terraform
terraform init

# create/update resource
terraform apply -var-file staging.tfvars
```

### DO NOT Destroy Project

Destroying the project may leave the App Engine instance in a broken state: https://github.com/hashicorp/terraform-provider-google/issues/1973

```
# DO NOT DESTROY: may make the project unrecoverable
# terraform destroy
```
