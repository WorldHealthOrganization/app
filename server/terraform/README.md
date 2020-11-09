## Terraform

Terraform is used for [Infrastructure as Code](https://en.wikipedia.org/wiki/Infrastructure_as_code) (Iac).
Beyond the normal benefits of IaC, it serves essential roles for the WHO App
for transparency and security. Team policy is to use IaC and in particular Terraform
for as much configuration as possible. Particularly the WHO production servers.

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

```shell script
mkdir server/terraform/xxxx
cd server/terraform/xxxx

# new Terraform config
cp ../staging/main.tf .
emacs main.tf

terraform init
terraform apply
# Should create all resources without any errors
```

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

## Manual Setup

The final setup must be completed manually for each project. This configuration should be moved to terraform if it is supported in the future.

Production servers **MUST** be configured exactly as described here to:

- Provide full transparency on configuration
- Comply with the privacy policy

### Google Analytics

1. [Google Analytics Console](https://analytics.google.com/analytics/web/)
1. Select project, e.g. "who-myhealth-staging"
1. Data Settings
   1. Data Retention: "Event Data Retention" => 2 months
   1. "Reset user data on new activity" => off
1. Default Reporting Identity => select "By device only"

### Firebase

1. [Firebase Console](https://console.firebase.google.com/u/0/project/who-myhealth-staging/analytics/overview)
1. "Analytics" => "Retention"
1. Click "Enable Google Analytics"
1. Create account with name that matches project, e.g. "who-myhealth-staging"
1. Analytics location => "Switzerland" (this doesn't limit where Firebase processes data)
1. Disable "Use the default settings..."
   - Disable all settings, except:
   - Production: "Technical support" may only be enabled temporarily with WHO permission
   - Non-Production: enable "Technical support"
1. Select "I accept the Google Analytics terms"

### Firebase App Registration

This provides the config files that the Android and iOS apps need to communicate with the Firebase instance.

#### Android

1. [Firebase Console](https://console.firebase.google.com/u/0/project/who-myhealth-staging/analytics/overview)
1. "Project Overview" at top left of console
1. "+ Add app" => "Android" (left most icon)
1. Android package name: "org.who.WHOMyHealth"
   - **NOTE:** Android and iOS IDs are different
1. App nickname: "WHO COVID-19"
1. Skip "Debug signing cert"... might be needed for staging apks
1. "Register app"
1. "Download google-services.json" and move to `<repo>/client/android/app/`
1. TODO: need mechanism to switch between Firebase instances
1. Skip "Add Firebase SDK" and "Add initialization code"
1. Run Android app in simulator to confirm Firebase setup

#### iOS

1. Repeat steps 1..3 above but select "iOS" (2nd icon on left)
1. iOS bundle ID: "int.who.WHOMyHealth"
   - **NOTE:** Android and iOS IDs are different
1. App nickname: "WHO COVID-19"
1. App Store ID: leave blank except for production
1. "Register app"
1. "Download GoogleService-Info.plist" and move to `<repo>/client/ios/Runner/`
1. TODO: need mechanism to switch between Firebase instances
1. Skip "Add Firebase SDK" and "Add initialization code"
1. Run iOS app in simulator to confirm Firebase setup
