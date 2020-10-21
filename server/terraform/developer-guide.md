## How to create and setup GCP projects using terraform

### Prerequisites

- [Install Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/gcp-get-started)
- Make sure you have access to `who-terraform-admin` project.
- [Create a new key](https://www.terraform.io/docs/providers/google/guides/getting_started.html#adding-credentials) for the `terraform@who-terraform-admin.iam.gserviceaccount.com` service account in the `who-terraform-admin` project, download the JSON credentials, and configure your environment:

  ```sh
  export GOOGLE_APPLICATION_CREDENTIALS=<path to json credentials>
  ```

### Create or update a GCP project

- Change directory into `terraform/` and deploy

  ```sh
  cd server/terraform
  terraform init
  terraform apply -var-file=staging.tfvars
  # to delete resource
  terraform destroy
  ```
