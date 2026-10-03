+++
title = "Installing"
description = "Install ivx/ai Chat on macOS, Windows, Linux, Android and iOS, or run it in Chrome, Firefox and Safari."
weight = 0
+++

ivx/ai Chat runs as a web app in any modern browser and ships native apps
for the desktop platforms and Android. Apps, installers and the bridge are all
published on the
[releases page](https://github.com/ivxlabs/ivxai-app/releases/latest).

There are three ways to use it:

- **Hosted** — open [ai.ivx.run/chat](https://ai.ivx.run/chat) and start
  chatting. Nothing to install.
- **Installed** — the apps below, for macOS, Windows, Linux and Android,
  and the extensions for Chrome and Firefox.
- **Self-hosted** — your own copy on a VPS or your own computer. See
  [Self-hosting](@/docs/self-hosting.md).

Some providers refuse requests made from a browser. The desktop and Android
apps carry their own proxy and need nothing configured, and the extensions
don't need one; the web version goes through
[the bridge](@/docs/bridge.md) running on your machine:

```
brew install ivxai-bridge
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
alone is `cargo build --release -p ivxai-bridge`, Rust only, and the web app
alone is `npm run web:build`. The details, including the mobile builds, are in
[Building it](@/docs/building.md).

## Android

Take the APK from the [latest release](https://github.com/ivxlabs/ivxai-app/releases/latest).
It needs Android 7.0 or newer.

- `ivxai-chat-<version>-android-arm64-v8a.apk` fits nearly every phone from
  the last several years.
- `ivxai-chat-<version>-android-universal.apk` fits all of them, at about
  three times the size. Take it if you aren't sure.

Open the downloaded file to install it. The first time, Android asks you to
allow installs from your browser or file manager.

The APK is signed with our own key rather than a store's. The release notes
list the signing certificate's SHA-256 fingerprint; to check a download
against it:

```
apksigner verify --print-certs <downloaded-file>.apk
```

It isn't on Google Play or F-Droid yet. To build it yourself, see
[Building it](@/docs/building.md#android-and-ios).

## iOS

There is no store build yet. From the cloned repository, with Xcode in place:

```
npx tauri ios init
npm run ios
```

## Chrome

Install the extension from the
[Chrome Web Store](https://chromewebstore.google.com/detail/ivxai-chat/hagajeejempjjekliknlahninodaejmb).
The web version also runs in Chrome: open
[ai.ivx.run/chat](https://ai.ivx.run/chat) and choose *Install* to keep it as
an app; after the first load it works offline.

## Firefox

Install the extension from
[addons.mozilla.org](https://addons.mozilla.org/firefox/addon/ivx-ai-chat/).
The web version also runs in Firefox: open
[ai.ivx.run/chat](https://ai.ivx.run/chat).

## Safari

The web version runs in Safari: open
[ai.ivx.run/chat](https://ai.ivx.run/chat) and choose *Add to Home Screen* to
keep it as an app; after the first load it works offline.

Safari blocks an HTTPS page from calling `http://127.0.0.1`, so the bridge
needs to serve the page as well — see
[the bridge](@/docs/bridge.md#safari).