+++
title = "The CORS bridge"
description = "A small daemon that lets the browser reach endpoints it would otherwise refuse to call — Ollama on its defaults, a bare llama.cpp build, an old company proxy."
weight = 8
+++

ivx/ai Chat talks to your provider straight from the browser. That works until
the provider sends no CORS headers: the endpoint is fine and your machine can
reach it perfectly well, but the browser will not let a web page do so.

`ivx-bridge` is a small program that runs on your machine and makes that call
for the page. It is off until you turn it on.

The desktop and mobile apps carry the same bridge inside them, so there is
nothing to install and nothing to configure there — **Settings → CORS bypass**
simply reads *Built into this app*.

## Installing it

macOS:

```
brew tap ivxlabs/tap
brew trust ivxlabs/tap
brew install ivx-bridge
```

Windows and Linux: take the `.tar.gz` from the
[latest release](https://github.com/ivxlabs/ivxai-app/releases/latest) and put
the binary somewhere on your `PATH`.

## Running it

```
ivx-bridge
```

```
ivx-bridge 0.2.2 on http://127.0.0.1:8787
  accepting: http://localhost:*, https://ai.ivx.run, …
  connect:   ivx/ai Chat -> Settings -> CORS bypass -> Look for the bridge
```

Then open **Settings → CORS bypass** in the app and choose **Look for the
bridge**. Once it answers, provider calls go through it, and the same switch
turns it off again at any time.

To keep it running across reboots:

```
ivx-bridge --install-service      # launchd on macOS, systemd --user on Linux
brew services start ivx-bridge    # the Homebrew equivalent
```

`ivx-bridge --uninstall-service` removes it again. The service keeps whatever
options you installed it with, so `ivx-bridge --install-service --port 9000 -v`
installs a service on port 9000.

## What it does, and does not do

The bridge has one job: `POST /proxy?url=<absolute URL>` forwards the request
and streams the answer back with the headers a browser wants.

- **Nothing is inspected.** It does not know what a chat completion is and
  never parses a body. Responses are piped through frame by frame, so a
  streamed reply still arrives token by token.
- **Nothing is kept.** No disk, no cache, no request log. `-v` prints one line
  per request — method, host, status — and never headers or bodies.
- **Browser-specific headers are dropped** before the request goes out:
  `Origin`, `Referer`, `Cookie`, `Accept-Encoding`. Several providers reject a
  request that claims to come from a page they do not recognise.

Your key still travels with the request, and the request still goes to the
endpoint you configured. The bridge only adds one hop, over loopback, on your
own computer.

## Who is allowed to use it

A daemon that forwards to any URL would be useful to any page in your browser,
not just this one, so the list of origins it accepts is the whole security
boundary. It holds because the browser sets `Origin` itself and a page cannot
forge it — a site you happen to visit cannot borrow the bridge to reach your
router's admin page.

Accepted by default: `https://ai.ivx.run`, `https://o.eval.blog`,
`https://ivxlabs.github.io`, any loopback address on any port, and the app's
own webview. Everything else gets a 403 naming the flag that would let it
through. Add your own with `--allow-origin <origin>`, or replace the list
entirely with `--only-origin <origin>`.

A request with **no** `Origin` is accepted: those come from things that are not
browsers, which could already reach the same endpoints directly. On a shared
machine, use `--token <secret>` and put the same secret in **Settings → CORS
bypass**.

## Local MCP servers

A browser cannot start a program, so an MCP server that speaks over stdin and
stdout is out of reach of the page even when it is running on the same machine.
The bridge covers that too: `/mcp/stdio` starts the server and relays JSON-RPC
to it, which is how **Settings → MCP** can use a command-line MCP server.

This is worth being plain about: whatever can use your bridge can start
programs on your machine. On a shared or exposed machine, set a token.

## Safari

Chrome and Firefox treat `http://127.0.0.1` as trustworthy, so an HTTPS page
may call it. Safari does not, and blocks it as mixed content.

The way out is to stop being cross-origin — let the bridge serve the app as
well, so the page and the bridge share one address:

```
ivx-bridge --ui-dir /path/to/dist
```

See [Self-hosting](@/docs/self-hosting.md) for where that `dist` comes from.

## Options

```
-p, --port <port>          Port to listen on (default 8787)
    --host <addr>          Address to bind (default 127.0.0.1)
    --allow-origin <o>     Also accept this browser origin (repeatable)
    --only-origin <o>      Accept only the origins given this way (repeatable)
    --allow-any-origin     Accept every origin. Development only
    --token <secret>       Require this token on /proxy
    --ui-dir <dir>         Also serve a built copy of ivx/ai Chat from here
    --insecure             Do not verify TLS upstream. Local self-signed only
    --connect-timeout <s>  Seconds to wait for a connection (default 30)
-v, --verbose              One line per request
    --install-service      Install and start a login service
    --uninstall-service    Stop and remove it
```

## When it does not work

**Settings → CORS bypass** tells the two failures apart, because they have very
different fixes:

- *Nothing answered* — the bridge is not running, or it is on another port.
  Check the address in the same screen.
- *Running, but not accepting this origin* — it answered, but the page you are
  on is not on its list. Restart it with `--allow-origin <that origin>`.
