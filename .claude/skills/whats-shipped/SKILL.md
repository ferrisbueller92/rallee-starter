---
name: whats-shipped
description: Reads SHIPPED.md and explains what's in the repo conversationally. Use when the operator asks "what's in this repo", "what skills do I have", "inventory", or "what can this do".
triggers:
  - "what's in this repo"
  - "whats in this repo"
  - "what do I have"
  - "what's shipped"
  - "whats shipped"
  - "inventory"
  - "what skills do I have"
  - "what can this do"
---

# What's Shipped

Conversational interface to `SHIPPED.md`. The "talk to your code" capability.

## When this fires

Operator asks anything about what's installed. Auto-fires on the trigger phrases above. Manual: `/whats-shipped`.

## Protocol

1. **Read `SHIPPED.md`** at repo root.
2. **Read `VERSION`** to confirm the current version.
3. **Identify what the operator actually wants to know:**
   - Just the list? → Read the manifest, present succinctly.
   - A specific category? ("What skills do I have?") → Filter to that section.
   - A specific component? ("What does /critique do?") → Read the SKILL.md and explain.
4. **Present in plain language** — not raw markdown, conversational.

## Output format

If asked broadly ("what's in this repo"):

```markdown
**Rallee Starter v[VERSION]** — your operating layer over Claude Code.

Here's what's installed:

**9 skills you can invoke:**
- `/research-analyst` — deep research with citations
- `/design-brief` — Canva-ready briefs from your brand bible
- `/brand-bible` — query your tokens, voice, palette
- `/humanise-text` — strip AI tone from any draft
- `/critique` — adversarial review (harsh but useful)
- `/vault-search` — semantic search over your vault
- `/session-close` — capture today's decisions and lessons
- `/whats-shipped` — this skill
- `/update` — pull latest improvements

**3 hooks running silently:**
- Blocks reads of `.env` / credentials
- Blocks destructive commands (rm -rf, force-push)
- Loads your context on every session start

**1 tool:**
- `vault_search.py` — semantic search engine

**Your brand bible** lives in `resources/brand/rallee/` — Claude reads it on every brand-related question.

Try `what's new` or `any updates` to check for improvements from upstream.
```

If asked about a specific skill ("What does /critique do?"):

Read the SKILL.md, explain in 2-3 sentences:
```markdown
**`/critique`** — adversarial reviewer. You paste a doc/email/proposal/design, it scores it 1-20 with a verdict (Ship / Fix / Kill) and tells you exactly what to change. Harsh by design — point is to catch problems before they ship.

Triggers: "critique this", "review this", "roast this", "what's wrong with this", "tear this apart".
```

## Chaining

If the operator follows up with "how do I use [skill]?", read that skill's SKILL.md and walk through the protocol.

If they ask "what's new?", chain to `/update`.
