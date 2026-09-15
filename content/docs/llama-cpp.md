+++
title = "llama.cpp"
description = "Point ivx/ai Chat at a llama.cpp server running on your machine."
weight = 3
[extra]
base_url = "http://localhost:8080/v1"
key = "not needed"
+++

A bare llama.cpp build serves an OpenAI-compatible API on your own machine.

## Base URL

```
http://localhost:8080/v1
```

No API key is needed.

## Adding it

Open **Settings → Providers**, add llama.cpp from the preset list, then use
**Fetch models**. If the build exposes no `/models` route, choose
*Type a model name* instead — hand-typed names are remembered per provider.
