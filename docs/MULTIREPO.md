# This doc describes a workflow for using multiple repositories in a development flow.

## Problem
For some of the assets we (will) use in the app we do not have the rights to freely distribute them. Githubs' ToS specify that anything in the public repo must be freely redistributable.
This means that we need a flow where we have a public repo for doing the main work and a private for storing those assets and putting them in at build time.

## Scope
This document is only about the mobile app(s), it is not about anything server-side.

## Proposed solution
We will have 2 repositories set up: App and Overlay.

The App repository will contain everything to build the app on a developer's machine.
The App repository will contain an empty theme directory. When looking for an 
The Overlay repository will contain:
  - A submodule, which is the App repository
  - An overlay directory
  - Build scripts that will ensure the build uses files from the overlay, if they exist and falls back to defaults otherwise

The overlay directory can only contain white-listed paths; this prevents the Overlay repository from accidentally adding features. 
Furthermore the overlay directory can only contain files that are present in the App repository; this prevents situations where the App repository doesn't build without the Overlay repository.
Any images in the the Overlay repo must have the exact same dimensions as the corresponding image in the App repo.

Identified paths for the overlay:
  - client/flutter/assets
  - client/flutter/android/app/src/main/res
  - client/flutter/ios/Runner/Assets.xcassets

From a developer's perspective there will be 2 scenarios: you're working on the app, or you're working on the design.
If you work on the app you only use the App repository.
If you're working on design you will need to checkout the Overlay repository, including the App repo submodule.

Process 1: create a new public asset
- Work in the App repo, add the asset as usual

Process 2: replace a public asset with a private one
- Create your private asset in the overlay directory in the same path of the public asset you want to replace.

Process 3: create a new private asset
- Do process 1
- Do process 2

Process 4: remove a private asset
- Remove the file from the overlay folder

Process 5: remove a public asset
- Do process 4
- Delete the asset from the App repo


While this process will work for unique assets, there is an issue with scaled assets. Suppose we have 3 variants of an app icon that also have private versions.
If a 4th variant gets added in the App repo, we want to make sure that the build in the Overlay repo fails until we've added that variant as well.

One way to do this would be to enforce that all our assets have only 1 source and variants must be built dynamically before executing the build
This would then allow us to remove those scaled assets from version control. Taking this one step further would be do this for platform specific assets as well.

A simple pre-build script could handle this based on some kind of definition, for example:
```yaml
  assets:
    - file: asset-path/test.png
      targets:
        - scale: 50%
          targets: 
            - assets/large/test.png
        - scale: 20%
          targets: 
            - assets/medium/test.png
        - scale: 10%
          targets: 
            - assets/small/small.png
        
````

More generically, we could choose to store hashes of all or some asset files in the Overlay repo, this allows us to fail our build when assets in the App repo change. That way
we can force a developer to confirm that the overridden assets are still correct.
A simple implementation would run something like this:

```bash
find ./app/client/flutter/assets -type f | xargs md5sum > assets.lock
find ./app/client/flutter/android/app/src/main/res -type f | xargs md5sum > android-assets.lock
find ./app/client/flutter/ios/Runner/Assets.xcassets -type f | xargs md5sum > ios-assets.lock 
```

Checking would be as simple as:
```bash
md5sum -c *.lock --strict
```

Building in the overlay would then consist of a few copies first:
Running in the overlay repo would require us to first copy the assets in the overlay:
```bash
mkdir overlay-build
cp -R ./app/client/flutter overlay-build
cp --remove-destination -R ./overlay/assets overlay-build/flutter/
cp --remove-destination -R ./overlay/android-assets overlay-build/flutter/android/app/src/main/res
cp --remove-destination -R ./overlay/ios-assets overlay-build/flutter/ios/Runner/Assets.xcassets
(cd overlay-build/flutter; flutter build appbundle) 
```
