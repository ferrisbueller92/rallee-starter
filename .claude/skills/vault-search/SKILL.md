---
name: vault-search
description: Semantic search across the operator's vault — finds content by meaning, not just keywords. Use when the operator asks "have we written about X", "find anything I've covered on Y", or before answering questions about past work.
triggers:
  - "find anything I've written about"
  - "have we covered"
  - "what did we write about"
  - "semantic search"
  - "search my vault"
  - "find my notes on"
---

# Vault Search

Semantic search over the operator's working folder. Wraps `tools/vault_search.py`.

## When this fires

User asks a question that references past work. Auto-fires before answering "have we written about", "what did we decide", etc. Manual: `/vault-search <query>`.

Chains: should fire FIRST when answering memory-dependent questions, before any web research.

## Protocol

1. **Restate the query** in one sentence if it's complex.
2. **Run `vault_search.py`** with the query.
3. **Read the top 3-5 hits** and synthesise what they say.
4. **Surface the file paths** so the operator can open them.
5. **If no hits**, say so honestly: "Nothing in your vault matches that. Want me to research it instead?"

## Usage

```bash
python tools/vault_search.py "your query here"
```

The tool returns the top-K results with file paths and relevance scores.

If the operator has set `ANTHROPIC_API_KEY` in `.env`, search uses embedding-based semantic matching (sentence-transformers locally — no API call needed). Without the embedding model installed, falls back to ripgrep keyword search.

## Output format

```markdown
## Vault search — "[query]"

**Top matches:**

1. [`file/path.md`] — [1-sentence what it says]
2. [`file/path.md`] — [1-sentence what it says]
3. ...

**Synthesis:**
[2-3 sentences answering the operator's underlying question, citing the files above.]

[If relevant: "Other related files: ..."]
```

## When the vault is empty

On day one, the seed/ folder contains one file (AU recruitment market notes). Otherwise the vault is empty until the operator starts writing. If nothing's found and the vault is genuinely empty, say so.

## Indexing

The first run on a vault triggers a one-time index build (~10 seconds for a small vault). Subsequent searches use the cached index. If you've added many new files, regenerate the index:

```bash
python tools/vault_search.py --rebuild
```
