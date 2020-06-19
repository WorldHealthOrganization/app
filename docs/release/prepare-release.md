# Preparing a new release

_Note these instructions are only for creating a release version of the app that can be used by WHO, not for the entire release lifecycle. For the latter, see [here](../README.md)._

## Add the WHO private repo

The WHO private repo has production configuration and private assets that are not in this repository. Clone this repository and fetch its branches:

```
git remote add release https://github.com/WorldHealthOrganization/app-private-who.git
git fetch release
```

## Create a new release branch

Create a release branch; it should be named `release/vX.X.X` where `X.X.X` is the app version. Merge in the release branch from the previous version, so that the produciton configuration and private assets are added, and finally push this branch to the private repository.

```
git checkout -b release/v0.11.0
git merge release/v0.10.0
git push release release/v0.11.0
```

## Create a tag and release

Go to the "Releases" section of the app-private-who GitHub repository. Create a new tag with the release name (such as `v0.11.0`), and add a description of what has been changed.

## Next steps

Steps for building the app on the WHO's end are found in [manual-build.md](manual-build.md).
