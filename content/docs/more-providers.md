+++
title = "Groq, Mistral, Together and DeepSeek"
description = "Add further hosted providers from the preset list, or any OpenAI-compatible endpoint."
weight = 7
[extra]
base_url = "see presets"
key = "required"
+++

Groq, Mistral, Together and DeepSeek are all available from the preset list
under **Settings → Providers**. Each one requires a key.

## Anything else

Point **Custom OpenAI-compatible** at anything speaking the OpenAI chat API.
Paste a key if the endpoint needs one, then use **Fetch models**.

Endpoints with no `/models` route are fine: the model picker and **Default
model** both offer *Type a model name*, and hand-typed names are remembered per
provider.
