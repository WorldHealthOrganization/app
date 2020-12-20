# Security Policy

## Reporting a Vulnerability

We are working on a Vulnerability Disclosure Program for reporting issues.
Once launched, we will link to it here. In the mean time, temporarily email
github@brunobowden.com with issues to report.

## Hacking Server

Please do all security testing against the dedicated `hack.whocoronavirus.org` server.
Follow the [build instructions](https://github.com/WorldHealthOrganization/app/blob/master/client/README.md),
and append `--flavor hack` to all build commands to use it. The following build
command will deploy the app to Android and iOS, simulator or connected device,
pointing to the "hack server":

```
flutter run --flavor hack
```

It should not be an issue if you break the hack server but please be thoughtful in doing
so. Please keep treat any server data as confidential but by design it shouldn't contain
any private data. Please be more careful with the other `*.whocoronavirus.org` servers
as they're used for active development.

## Architecture

Please see the [design docs](https://github.com/WorldHealthOrganization/app/blob/master/docs/devdesign/README.md)

## Supported Versions

As a managed service, we expect to always run on the latest version. The clients
aren't pushed to update unless there is a security issue.
