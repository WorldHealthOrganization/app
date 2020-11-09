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

### New Project

When new projects are added (e.g. prod, staging, hack, ...) - for each project:

1. `mkdir server/terraform/xxxx`
1. `cd server/terraform/xxxx`
1. Create `main.tf` (suggestion is to base it on `staging/main.tf`)
1. `terraform init`
1. `terraform apply` so terraform creates the project (this gives it the right permissions)
1. Some resource creation will fail due to missing permissions but it will create the project
1. Enable access for every API that's needed:
   1. Repeat for each link below
   1. Select newly created project
   1. Click "ENABLE"
   - https://console.developers.google.com/apis/library/compute.googleapis.com
   - https://console.developers.google.com/apis/library/dns.googleapis.com
   - https://console.cloud.google.com/apis/library/firebase.googleapis.com
1. `terraform apply` again and it will complete successfully

### Update Project

The `apply` can be used to both create and update the server config:

```sh
# setup
cd server/terraform/xxxx
terraform init

# update resource
terraform apply
```

### DO NOT Destroy Project

As this may leave the App Engine instance in a broken state:
([ref](https://github.com/hashicorp/terraform-provider-google/issues/1973)) and
destroy data and IP addresses that can't be recovered.

```sh
# DO NOT DESTROY: will make the project unrecoverable
# terraform destroy
```
