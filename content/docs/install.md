+++
title = "Installing"
description = "Install ivx/ai Chat on macOS, Windows, Linux, Android and iOS, or run it in Chrome, Firefox and Safari."
weight = 0
+++

ivx/ai Chat runs as a web app in any modern browser and ships native apps
for the desktop platforms below. Apps, installers and the bridge are all
published on the
[releases page](https://github.com/ivxlabs/ivxai-app/releases/latest).

Some providers refuse requests made from a browser. The desktop app carries
its own proxy and needs nothing configured; the web version goes through the
bridge running on your machine:

```
brew install ivx-bridge
```

Not on macOS? Take the bridge from the [releases page](https://github.com/ivxlabs/ivxai-app/releases/latest).

## macOS

```
brew tap ivxlabs/tap
brew trust ivxlabs/tap
brew install --cask ivxai-chat
```

## Windows

Take the installer from the [latest release](https://github.com/ivxlabs/ivxai-app/releases/latest).
Nothing is signed with a paid certificate, so SmartScreen objects on first
launch; the release notes say how to get past it.

## Linux

Take the Debian package from the [latest release](https://github.com/ivxlabs/ivxai-app/releases/latest)
and install it with your package manager, for example:

```
sudo dpkg -i <downloaded-file>.deb
```

## From source

```
git clone --recurse-submodules https://github.com/ivxlabs/ivxai-app
cd ivxai-app
npm install
```

The desktop app builds with `npm run build`; that needs Rust, Node and the
[Tauri prerequisites](https://tauri.app/start/prerequisites/). The bridge
alone is `cargo build --release -p ivx-bridge`, Rust only.

## Android

There is no store build yet. From the cloned repository, with the Android SDK
and NDK in place:

```
npm run android:init
npm run android
```

## iOS

There is no store build yet. From the cloned repository, with Xcode in place:

```
npx tauri ios init
npm run ios
```

## Chrome

The extension is coming soon. The web version already runs in Chrome: open
[ai.ivx.run/chat](https://ai.ivx.run/chat) and choose *Install* to keep it as
an app; after the first load it works offline.

## Firefox

The extension is coming soon. The web version already runs in Firefox: open
[ai.ivx.run/chat](https://ai.ivx.run/chat).

## Safari

The web version runs in Safari: open
[ai.ivx.run/chat](https://ai.ivx.run/chat) and choose *Add to Home Screen* to
keep it as an app; after the first load it works offline.