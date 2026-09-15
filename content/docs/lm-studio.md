+++
title = "LM Studio"
description = "Point ivx/ai Chat at a model served locally by LM Studio."
weight = 2
[extra]
base_url = "http://localhost:1234/v1"
key = "not needed"
+++

LM Studio serves models locally over an OpenAI-compatible API.

## Base URL

```
http://localhost:1234/v1
```

No API key is needed.

## Adding it

Open **Settings → Providers**, add LM Studio from the preset list, then use
**Fetch models**. **Scan for local servers** also probes the usual ports and
adds whatever answers.
