+++
title = "Installing"
description = "Install ivx/ai Chat on macOS, Windows, Linux, Android and iOS, or run it in Chrome, Firefox and Safari."
weight = 0
+++

ivx/ai Chat runs as a web app in any modern browser and ships native apps
for the desktop platforms below. Apps, installers and the bridge are all
published on the
[releases page](https://github.com/ivxlabs/ivxai-app/releases/latest).

There are three ways to use it:

- **Hosted** — open [ai.ivx.run/chat](https://ai.ivx.run/chat) and start
  chatting. Nothing to install.
- **Installed** — the apps below, for macOS, Windows and Linux.
- **Self-hosted** — your own copy on a VPS or your own computer. See
  [Self-hosting](@/docs/self-hosting.md).

Some providers refuse requests made from a browser. The desktop app carries
its own proxy and needs nothing configured; the web version goes through
[the bridge](@/docs/bridge.md) running on your machine:

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
git clone https://github.com/ivxlabs/ivxai-app
cd ivxai-app
npm install
```

The desktop app builds with `npm run build`; that needs Rust, Node and the
[Tauri prerequisites](https://tauri.app/start/prerequisites/). The bridge
alone is `cargo build --release -p ivx-bridge`, Rust only, and the web app
alone is `npm run web:build`. The details, including the mobile builds, are in
[Building it](@/docs/building.md).

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

Safari blocks an HTTPS page from calling `http://127.0.0.1`, so the bridge
needs to serve the page as well — see
[the bridge](@/docs/bridge.md#safari).