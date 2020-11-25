## Terraform

Terraform is used for [Infrastructure as Code](https://en.wikipedia.org/wiki/Infrastructure_as_code) (Iac).
Beyond the normal benefits of IaC, it serves essential roles for the WHO App
for transparency and security. Team policy is to use IaC and in particular Terraform
for as much configuration as possible. Particularly the WHO production servers.

### Development Organization

To allow development to be done more easily by the open source community. A
development organization is maintained at whocoronavirus.org separate from
WHO production infrastructure. This organization and the projects it hosts
set an expectation of no privacy. Release versions of the app must never
connect to these development servers.

The development organization is outside of WHO control and responsibility.
Along with no privacy expectations, it makes it easier to grant access and
do development. This access does not give any access to the WHO production
infrastructure.

To start with, use a Google Cloud organization of your own. At some point,
you can approach one of the maintainers about access to the development
organization.

### Terraform Service Account

Service accounts are used by Terraform to create and edit the cloud projects.
To maintain separation between these accounts and the projects they're
managing, follow these instructions to create a `who-terraform-admin`
project (this already exists in the development organization):

https://github.com/GoogleCloudPlatform/community/blob/master/tutorials/managing-gcp-projects-with-terraform/index.md#create-the-terraform-admin-project

This creates a Terraform service account with the permissions for:

- Billing Account User
- Project Creator

Secondly grant the service account access to the DNS records:

1. https://www.google.com/webmasters/verification/home?hl=en
1. Select domain you own
1. Scroll down to bottom and select "Add an owner", example for dev org:

```
terraform@who-terraform-admin.iam.gserviceaccount.com
```

Terraform access to the WHO production project is limited to only the project
itself and not the wider organization. The service account is created within the
project instead. The who-mh-prod-in-dev project is used to replicate this
environment in the development organization. Starting from a newly created empty
project, create a `who-terraform-prod-admin`
[service account](https://console.cloud.google.com/iam-admin/serviceaccounts)
with the following permissions (required to create App Engine instance):

- Project Owner

### Setup

- [Install Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/gcp-get-started)
- [Service Account Console](https://console.cloud.google.com/iam-admin/serviceaccounts?project=who-terraform-admin&folder=&organizationId=&supportedpurview=project)
- Ask maintainers for access (limited to small group)
- Create a new key
  - Visit (example for development organization): https://console.cloud.google.com/apis/credentials/serviceaccountkey?project=who-terraform-admin&organizationId=532343229286
  - Service Account: select "Terraform"
  - Click "Create", download file

Configure the credentials:

```sh
export GOOGLE_APPLICATION_CREDENTIALS=<path to json credentials>
```

This uses the `terraform@who-terraform-admin.iam.gserviceaccount.com` service account
in the `who-terraform-admin` project. To complete the setup, navigate to a particular
directory and apply the project:

```sh
cd server/terraform/prod-in-dev

terraform init
terraform apply
```

Note: This may fail with the following error
`Error: googleapi: Error 409: Sink _Default already exists, alreadyExists`.
due to https://github.com/hashicorp/terraform-provider-google/issues/7811.

Run import and re-apply to continue.

```sh
terraform import module.myhealth.google_logging_project_sink.default projects/$PROJECT_ID/sinks/_Default
terraform apply
```

See the [Production Setup](#production-setup) for special instructions for the
`who-mh-prod` and `who-mh-prod-in-dev` projects. The other projects don't need
any special setup.

### External Documentation

- [Terraform adding credentials](https://www.terraform.io/docs/providers/google/guides/getting_started.html#adding-credentials)
- [Securely handling keys](https://cloud.google.com/iam/docs/understanding-service-accounts?_ga=2.87249435.-2051693357.1581897767#managing_service_account_keys)

### Current Projects

The WHO Production server is the only server that follows the privacy policy.
There is no expectation of privacy for the development organization projects,
which are in the list below. The project renaming is still in progress:

| Server Name        | Purpose                                                 |
| ------------------ | ------------------------------------------------------- |
| who-mh-hack        | Dedicated server for penetration testing                |
| who-mh-prod-in-dev | Replicates permissions and setup of who-mh-prod project |
| who-mh-prod        | WHO Production infrastructure, Privacy Policy compliant |
| who-mh-staging     | CI server updated from GitHub repo                      |

### New Project

Follow these steps and update the project list above:

```sh
mkdir server/terraform/xxxx
cd server/terraform/xxxx

# Terraform new config should be based on staging
cp ../staging/main.tf .
emacs main.tf

terraform init
terraform apply
# Should create all resources without any errors

# Add server reference in top level terraform to ensure validation
# server/terraform/main.tf
# `terraform apply` should not be used here, instead only individual projects
```

### Terraform Apply

`terraform apply` can be used to both create and update the server config:

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

### Production Setup

Terraform requires special setup since the service account uses an existing project.
Terraform can't maintain the project state as the `google_project.billing_account`
can only be edited with the "Billing Account User" permissions
(see #terraform-service-account). The `who-mh-prod-in-dev` in the development
organization replicates the permissions model of the `who-mh-prod` project in production.

After creating an empty project with a matching project name, use `terraform apply`
as normal to create and update the project. First time use will produce this error:

```sh
Error: Error creating ManagedZone: googleapi: Error 400: Please verify ownership of the 'prod-in-dev.whocoronavirus.org.' domain (or a parent) at http://www.google.com/webmasters/verification/ and try again, verifyManagedZoneDnsNameOwnership
```

Fix this by setting up a DNS A Record that points to the IPv4 global address.
The DNS A Record is specified in the Terraform domain variable, e.g.
staging.whocoronavirus.org. Use `terraform state` to get the IPv4 address it needs
to point to:

```sh
terraform state show module.myhealth.module.lb.google_compute_global_address.ipv4
# module.myhealth.module.lb.google_compute_global_address.ipv4:
resource "google_compute_global_address" "ipv4" {
address = "34.107.166.96" ...
```

If the service account has "Project Editor" access instead of "Project Owner",
it will produce the following error. This still creates an App Engine instance
but one that can't be edited by Terraform leaving the project permanently broken.

```sh
Error: Error creating App Engine application: googleapi: Error 403: The caller does not have permission, forbidden
```

## Manual Setup

The final setup must be completed manually for each project. This configuration
should be moved to terraform if it is supported in the future.

Production servers **MUST** be configured exactly as described here. Changes **MUST**
be made through code and merged before being manually applied. Only exception is
emergency changes for system reliability. In that case, this documentation must be
promptly updated with any permanent changes to the server. The motivation is:

- Transparency on configuration
- Privacy policy compliance

### Analytics

Analytics may be disabled by the user on their device.

#### Project Settings

1. Firebase Console Integrations: https://console.firebase.google.com/u/0/project/who-mh-staging/settings/integrations
1. Click on "Google Analytics" => "Enable"
1. "Configure Google Analytics" page:
   - Dev: use "who-mh-no-privacy" Google Analytics account
   - Prod: use WHO existing analytics account
   - For both, click "Enable Google Analytics"
1. Click on link below "Linked Google Analytics account"
1. Select "Account Settings"
1. Configure "Country of Business" (doesn't change where data is processed)
   - Dev: United States
   - Prod: Switzerland
1. Click "Save" at bottom of the page

#### Property Settings

1. Click on the left arrow to show the "Account" and "Property" columns
1. Click "Data Settings" from the "Property" column on the right
1. Click "Data Retention"
1. "Event data retention" => 2 months
1. "Reset user data on new activity" => Off
1. Click "Save"

### Firebase App Registration

This provides the config files that the Android and iOS apps need to communicate
with the Firebase instance. The files are automatically generated by Firebase
for all the platforms used. There's nothing sensitive in the files so they can
be added to the public repository.

#### iOS

1. [Firebase Console](https://console.firebase.google.com/u/0/project/who-mh-staging/overview)
1. Click "+ Add app" if shown
1. Select "iOS" (left most icon)
1. iOS bundle ID: `int.who.WHOMyHealth`
   - **NOTE:** Android and iOS IDs are different
1. App nickname: "WHO COVID-19"
1. App Store ID:
   - Dev: leave blank
   - Prod: 1503458183
1. "Register app"
1. "Download GoogleService-Info.plist"
1. Append project name to filename, e.g. "GoogleService-Info-staging.plist"
1. Add to repo: `client/ios/Runner/`
1. TODO: need mechanism to switch between Firebase instances, default is staging server
1. Skip "Add Firebase SDK" by clicking "Next"
1. Skip "Add initialization code" by clicking "Next"
1. Run iOS app in simulator to confirm Firebase setup

#### Android

1. [Firebase Console](https://console.firebase.google.com/u/0/project/who-mh-staging/overview)
1. Click "+ Add app" if shown
1. Select "Android" (2nd icon on left)
1. Android package name: `org.who.WHOMyHealth`
   - **NOTE:** Android and iOS IDs are different
1. App nickname: "WHO COVID-19"
1. "Debug signing cert":
   - Dev: leave blank
   - Prod: ????
1. "Register app"
1. "Download google-services.json"
1. Append project name to filename, e.g. "google-services-staging.json"
1. Add to repo: `client/android/app/`
1. TODO: need mechanism to switch between Firebase instances, default is staging server
1. Skip "Add Firebase SDK" by clicking "Next"
1. Skip "Add initialization code" by clicking "Next"
1. Run Android app in simulator to confirm Firebase setup

### Crashlytics

1. Crashlytics settings: https://console.firebase.google.com/u/0/project/who-mh-staging/crashlytics/
1. Click "Enable Crashlytics"
1. Force crash by uncommenting the lines around `FirebaseCrashlytics.instance.crash` in
   [`main.dart`](https://github.com/WorldHealthOrganization/app/blob/master/client/lib/main.dart)
1. Start app in simulator and watch for crash
1. Start app again as crashes are reported upon application restart
1. Verify crash is shown in [Firebase Console](https://console.firebase.google.com/u/0/project/who-mh-staging/crashlytics/)
1. Repeat for:
   - Android Simulator
   - iOS Simulator
1. **NOTE:** testing on multiple projects will [report crashes to wrong project](https://github.com/firebase/firebase-android-sdk/issues/2191). Only workaround is to change the `package_name` / `ApplicationId`.
