# Security Policy

## Reporting a Vulnerability

HackerOne hosts our Vulnerability Disclosure Program (VDP). Do not post sensitive
security issues on the public GitHub but report them to the HackerOne VDP instead:

https://hackerone.com/who-covid-19-mobile-app

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

## Documentation

- [Design Docs](https://github.com/WorldHealthOrganization/app/blob/master/docs/devdesign/README.md)
- [Open Security Issues](https://github.com/WorldHealthOrganization/app/issues?q=is%3Aissue+is%3Aopen+label%3Asecurity)

## Supported Versions

As a managed service, we expect to always run the server on a recent version.
The mobile clients will be prompted to update as new features are released and
in the case of a security issue.
