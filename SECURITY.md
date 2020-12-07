# Security Policy

## Reporting a Vulnerability

We are working on a Vulnerability Disclosure Program for reporting issues.
Once launched, we will link to it here.

## Hacking Server

There is a dedicated server for penetration testing: hack.whocoronavirus.org.
Please prioritize this server for hacking attempts. It should not be an issue
if you break the server but please be thoughtful in doing so. Please keep
treat any server data as confidential but by design it shouldn't contain
any private data.

Please be careful with the other \*.whocoronavirus.org servers as they're
used for development.

## "hack" build flavor

Follow the [build instructions](https://github.com/WorldHealthOrganization/app/blob/master/client/README.md),
appending `--flavor hack` to point to the hacking server:

```
flutter run --flavor hack
```

## Architecture

Please see the [design docs](https://github.com/WorldHealthOrganization/app/blob/master/docs/devdesign/README.md)

## Supported Versions

As a managed service, we expect to always run on the latest version. The clients
aren't pushed to update unless there is a security issue.
