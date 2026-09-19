+++
title = "Privacy"
description = "We collect nothing. This site is hosted on GitHub Pages, which keeps server logs we neither add to nor receive — install the app to avoid even those."
template = "page.html"
+++

We do not collect your data. There is no backend to collect it with, no
accounts to attach it to, no analytics, and no telemetry. Nothing in ivx/ai
Chat phones home, not even an error report.

This page says what that means precisely, and names the few things that do
reach someone else.

## Your conversations

Your chats, your API keys and your settings are stored in your own browser and
go nowhere else. In technical terms: conversations and messages in IndexedDB,
a few display preferences in localStorage, and the app's own files plus any
in-browser model weights in Cache Storage. You can export all of it, or delete
all of it, from Settings → Privacy & data. API keys can sit encrypted under a
passphrase you choose.

We never see any of it, because none of it is ever sent to us.

## Your AI provider

When you send a message, it goes from your browser straight to the endpoint you
configured — Ollama on your own machine, or OpenAI, Anthropic, OpenRouter, or
whatever else you pointed it at. It does not pass through us on the way.

What that provider does with what you send is governed by *their* privacy
policy, not ours. If you would rather nothing left your machine at all, run a
local model: [Ollama](@/docs/ollama.md), [LM Studio](@/docs/lm-studio.md),
[llama.cpp](@/docs/llama-cpp.md), or the in-browser option, which downloads a
model once and then answers without a network at all.

## This website

This site, and the hosted copy of the app at
[ai.ivx.run/chat](https://ai.ivx.run/chat), are static files served by **GitHub
Pages**. We run no server of our own and have added no analytics, no tag
manager, no third-party fonts and no cookies. Every file the site loads comes
from the site itself.

GitHub, however, is a web server, and web servers keep logs. GitHub states that
it may collect the IP addresses of visitors to a GitHub Pages site, along with
the usual request details, to keep the service secure and to meet its legal
obligations. See the
[GitHub Privacy Statement](https://docs.github.com/en/site-policy/privacy-policies/github-privacy-statement)
for what that covers.

Two things about those logs are worth stating plainly:

- **We do not receive them.** No visitor data from GitHub reaches us, and we
  have added nothing on top of it.
- **We cannot turn them off.** They are GitHub's, a condition of the hosting,
  and no choice of ours can switch them off for you.

## Avoiding that entirely

If you would rather not hand a log line to anyone, do not use the hosted copy.
Install the app instead:

- **Desktop and mobile** — macOS, Windows, Linux, Android and iOS. See
  [Installing](@/docs/install.md).
- **Browser extension** — Chrome, Firefox and Safari, carrying the same app.
- **Your own copy** — it is plain static files. See
  [Self-hosting](@/docs/self-hosting.md).

An installed copy carries every file it needs. It does not fetch the app from
us, so opening it contacts this site not at all, and there is nothing for a log
to record. The hosted version does check back here for a new build from time to
time, which an installed copy has no reason to do.

Everything is [free software](https://github.com/ivxlabs/ivxai-app) under the
GNU GPL v3.0 or later, so none of the above has to be taken on trust.

## The exceptions, named

Three things do reach a third party, and all three are yours to start:

- **In-browser models.** Choosing one downloads its weights from HuggingFace,
  once, and caches them. After that it needs no network.
- **Anything you switch on.** Optional features that talk to someone else —
  the MCP registry, a remote MCP server — say who they talk to at the moment
  you turn them on.
- **The provider you chose.** As above: your endpoint, your key, your traffic.

## Changes

If this policy changes, the change lands in
[the site's git history](https://github.com/ivxlabs) like everything else here,
where you can read exactly what changed and when.
