# This doc describes a workflow for using multiple repositories in a development flow.

## Problem
Certain assets will not be licensed under our public repository's open source license.
This means that we need a flow where we have a public repo for doing the main work and a private for storing those assets and putting them in at build time.

## Scope
This document is only about the mobile app(s), it is not about anything server-side.

## Implemented solution
We will have 3 repositories set up: App, Overlay and Build.

The App repository will contain the application with assets to build it locally. (this repo)
The Overlay repository will contain a directory structure similar to the structure of the App repository. (private repo)
The Build repo contains 2 submodules and the build scripts (https://github.com/WorldHealthOrganization/app-build-tools) 

## Building the app with the private assets
For information on building the repository with the private assets please visit the build-tools repository.
Note that to perform such a build you must have access to the private asset repository.
