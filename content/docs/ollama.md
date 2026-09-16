+++
title = "Ollama"
description = "Run open-weight models on your own machine or on Ollama Cloud, and point ivx/ai Chat at them."
weight = 1
[extra]
base_url = "http://localhost:11434 / https://ollama.com"
key = "not needed / required for Cloud"
+++

Ollama runs open-weight models on your own machine. It is seeded in ivx/ai Chat,
so it is already listed under **Settings → Providers** without being added.

## Base URL

```
http://localhost:11434
```

No API key is needed.

## Ollama Cloud

Ollama also offers a paid subscription, Ollama Cloud, which runs models on
their servers. Point a provider at:

```
https://ollama.com
```

It requires an API key from your Ollama account.

## Allowing browser requests

Ollama refuses cross-origin requests by default. Start it with your origin
allowed:

```
OLLAMA_ORIGINS='http://localhost:5173' ollama serve
```

The desktop app includes a local proxy and needs no such configuration.

## Choosing a model

Open the model picker and use **Fetch models**. Endpoints with no `/models`
route are fine — choose *Type a model name* instead, and hand-typed names are
remembered per provider.
