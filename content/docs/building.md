+++
title = "Building it"
description = "Build the web app, the CORS bridge and the desktop and mobile apps from source, and how a release is cut."
weight = 10
+++

Everything ships from one repository,
[ivxlabs/ivxai-app](https://github.com/ivxlabs/ivxai-app).

```
git clone https://github.com/ivxlabs/ivxai-app
cd ivxai-app
npm install            # also installs web/
```

| | |
| --- | --- |
| `web/` | the chat client — a browser app, no backend |
| `crates/ivx-bridge/` | the CORS bridge: a library, and a daemon around it |
| `src-tauri/` | the desktop and mobile shell, which embeds that library |

## Building

| What | Command | Needs |
| --- | --- | --- |
| The web app | `npm run web:build` → `web/dist` | Node |
| The bridge | `cargo build --release -p ivx-bridge` | Rust |
| The desktop app | `npm run build` | Rust, Node, [Tauri prerequisites](https://tauri.app/start/prerequisites/) |

## Running it while you work

```
npm run dev                       # the app, on the dev server
npm run web:dev                   # the page alone, http://localhost:5173
cargo run -p ivx-bridge -- -v     # the daemon, one line per request
cargo test --workspace            # the bridge's tests
npm --prefix web run mock         # a fake provider on :8124
```

Add `http://localhost:8124/v1` as a custom provider to exercise streaming,
Markdown rendering and error handling without spending anything.

A useful end-to-end check is a provider that sends *no* CORS headers, since
that is the case [the bridge](@/docs/bridge.md) exists for: point the app at
one, confirm the browser refuses it, then turn the bridge on and confirm it
streams.

Nothing runs any of this on push, so run it yourself before proposing a change.

## Android and iOS

Both build from the same repository but are not part of a release yet.

```
npm run android:init      # tauri android init, plus the overlay below
npm run android           # needs the Android SDK and NDK
npx tauri ios init
npm run ios               # needs Xcode
```

`src-tauri/gen/` is generated rather than committed, so anything the Tauri
template leaves out has to be re-applied after each init.
`scripts/android-overlay.mjs` is that step, and `npm run android` runs it for
you.

What it fixes: the app's own bridge is reached over `http://`, and since
Android 9 a release build may not make a cleartext request. Without the overlay
a release APK loads fine and then fails every provider call with
`ERR_CLEARTEXT_NOT_PERMITTED`. The overlay installs a network security config
permitting cleartext to `127.0.0.1` and `localhost` and nothing else, so the
rest of the app stays HTTPS-only. Debug builds are unaffected, which is why
only the release APK shows it.

## The web app on its own

`web/dist` is plain static files with a relative base, so it runs from any host
and any subdirectory — see [Self-hosting](@/docs/self-hosting.md).

[ai.ivx.run/chat](https://ai.ivx.run/chat) is built from `web/` by the publish
workflow of this site's own repository,
[ivxlabs/ivxlabs.github.io](https://github.com/ivxlabs/ivxlabs.github.io),
which also fails the build if a third-party origin appears in the bundle or the
service worker's placeholders survive it.

These documentation pages live there too, under `content/docs/` — so a change
to `ivx-bridge`'s command line is two commits: the code in `ivxai-app`, and the
page here.

## Releases

Bump the version with `npm run bump patch` (or `minor`, `major`, or an exact
`0.2.0`), commit it, and tag that commit `vX.Y.Z`. `release.yml` opens one
**draft** release and builds the app and the bridge for macOS, Windows and
Linux onto it; check the artefacts and publish. Publishing renders the
[Homebrew tap](https://github.com/ivxlabs/homebrew-tap) from
`packaging/homebrew/` and pushes it. Prereleases are skipped, so an `-rc` tag
can exercise the pipeline without moving Homebrew users.

Two things worth knowing before touching it:

- **The macOS `.dmg` is allowed to fail.** Tauri's dmg step drives Finder over
  AppleScript, which needs a desktop session and fails on a runner without one.
  The `.app.tar.gz` is built first and is the real deliverable, so the job
  warns and carries on.
- **The version has one home:** `[workspace.package]` in `Cargo.toml`. Both
  crates inherit it, and `tauri.conf.json` has no `version` field, so Tauri
  falls back to Cargo. `scripts/version.mjs` writes it there and mirrors it
  into `package.json`, `web/package.json` and the client name the app gives an
  MCP server; `npm run bump` is the only thing that should ever change them.
  The draft job runs `--check "$TAG"` and refuses to open a release whose tag
  disagrees.
