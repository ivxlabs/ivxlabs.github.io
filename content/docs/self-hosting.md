+++
title = "Self-hosting"
description = "Run your own copy of ivx/ai Chat: static files on any host, or the bridge serving the app and the proxy together, on a VPS or your own computer."
weight = 9
+++

The web version is plain static files with no backend, so hosting it yourself is
mostly a matter of putting a folder somewhere. There are two shapes:

- **Static files anywhere.** A web server, GitHub Pages, a folder on your NAS.
- **The bridge serving the app.** One process that serves the page *and*
  forwards provider calls — the simplest thing to put on a VPS, and the way to
  make it work in Safari.

Either way the app still keeps your conversations and keys in your own browser.
Nothing is stored on the host.

## Building it

```
git clone https://github.com/ivxlabs/ivxai-app
cd ivxai-app
npm install
npm run web:build
```

That leaves the site in `web/dist`. It uses relative paths, so it works from a
subdirectory as well as from the root of a domain.

## Static files anywhere

Copy `web/dist` to whatever serves your files. Nothing else is required.

Serve it over HTTPS if you can — a browser will not install it as an app, use a
service worker, or run the in-browser WebLLM models over plain HTTP, except on
`localhost`.

If you also want to reach providers that refuse browser calls, run
[the bridge](@/docs/bridge.md) on the machine where those providers are, and
allow your own origin:

```
ivx-bridge --allow-origin https://chat.example.com
```

## The bridge serving the app

The bridge can serve the built site itself. The page and the proxy then share
one address, which means nothing is cross-origin and Safari has nothing to
object to:

```
ivx-bridge --ui-dir /srv/ivxai/dist
```

```
ivx-bridge 0.2.2 on http://127.0.0.1:8787
  accepting: http://localhost:*, https://ai.ivx.run, …
  serving:   /srv/ivxai/dist — open http://127.0.0.1:8787/
```

On your own computer that is the whole setup. Open the address and, under
**Settings → CORS bypass**, point the bridge address at that same URL.

## On a VPS

Two things change once it is not your own machine.

**Put HTTPS in front of it.** The bridge speaks plain HTTP and has no
certificate handling, so leave it on loopback and let a reverse proxy terminate
TLS. With Caddy:

```
chat.example.com {
    reverse_proxy 127.0.0.1:8787
}
```

**Tell it about your domain.** The page is now served from
`https://chat.example.com`, and that is an origin the bridge does not know, so
it will refuse the proxy calls the page makes:

```
ivx-bridge --ui-dir /srv/ivxai/dist --token <secret> --only-origin https://chat.example.com
```

`--only-origin` replaces the default list rather than adding to it, so a public
deployment forwards for your page and nothing else.

Then, in the app: **Settings → CORS bypass**, set the address to
`https://chat.example.com`, paste the same token, and choose **Look for the
bridge**.

Keep it running with `ivx-bridge --install-service` (which keeps the options
you gave it), or write your own systemd unit if the server has no logged-in
user.

## Before you expose it

The bridge forwards to any URL it is given, and `/mcp/stdio` starts programs.
Anyone who can use your bridge can therefore reach anything your server can
reach, and run commands on it. So:

- **Always set `--token`** on anything that is not loopback-only.
- **Use `--only-origin`**, not `--allow-origin`, for a public deployment.
- **Never use `--allow-any-origin`** outside your own machine.
- Better still, keep it off the public internet: a VPN, a Tailscale network or
  an SSH tunnel to a loopback-bound bridge avoids the question entirely.

One more thing worth expecting: a bridge on a VPS reaches *that server's*
network. "Local" models then means models the server can see, not the ones on
your laptop.

## Which models

Nothing about hosting changes the providers — see [Installing](@/docs/install.md)
and the provider pages for how to point the app at Ollama, llama.cpp, OpenAI and
the rest.
