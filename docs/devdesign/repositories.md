# Multi-repository workflow

## Problem

Certain assets will not be licensed under our public repository's open source license.
This means that we need a flow where we have a public repository for doing the main work and a private repository for storing those assets and putting them in at build time.

## Scope

This document is only about the mobile app(s), it is not about anything server-side.

## Implemented solution

We have 3 repositories set up: App, Overlay and Build.

- This App repository contains the application with assets to build it locally.
- The private Overlay repository contains a directory structure similar to the structure of the App repository.
- The Build repository contains 2 submodules and the build scripts (https://github.com/WorldHealthOrganization/app-build-tools)

## Building the app with the private assets

For information on building the repository with the private assets please visit the build-tools repository.
Note that to perform such a build you must have access to the private asset repository.
