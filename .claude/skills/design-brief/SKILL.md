---
name: design-brief
description: Generates a structured Canva-ready brief from the operator's brand bible. Takes a request like "Need a LinkedIn post about X" and produces exact copy, hex codes, font specs, asset references, and layout suggestion. Operator pastes brief into Canva, applies Brand Kit, iterates fast.
triggers:
  - "design brief"
  - "canva brief"
  - "post about"
  - "carousel about"
  - "linkedin post"
  - "instagram post"
  - "need a design"
  - "social post"
---

# Design Brief

Bridge between Claude Code and Canva. Loads the brand bible, takes a content request, produces a brief Canva can execute against.

## When this fires

User asks for a social post, carousel, LinkedIn graphic, presentation slide, or any deliverable that will end up in Canva. Auto-fires on the trigger phrases above. Manual: `/design-brief <description>`.

## Protocol

1. **Load brand tokens.** Read `resources/brand/rallee/tokens.json`, `voice.yaml`, `typography.yaml`, `visual-style.yaml`. These are the constraints.
2. **Clarify the ask** if anything's ambiguous — format (square / portrait / story / carousel), platform (LinkedIn / IG / web), audience (clients / candidates / general).
3. **Generate the brief** with the structure below. Every brief is on-brand by default — pull colours from `tokens.json`, fonts from `typography.yaml`, voice from `voice.yaml`.
4. **Suggest 1-2 alternative angles** if the topic could be framed differently.
5. **Flag any asset that doesn't exist yet** — if the brief needs a photo we don't have, surface it.

## Output format

```markdown
## Design brief — [topic]

**Format:** [square 1080×1080 / portrait 1080×1350 / story 1080×1920 / etc.]
**Platform:** [LinkedIn / Instagram / web / etc.]
**Audience:** [who]
**Goal:** [one sentence]

### Copy

**Headline:**
[exact words]

**Sub / body:**
[exact words]

**CTA:**
[exact words]

### Visual spec

- **Background:** [hex code + name from brand bible]
- **Headline:** [font, weight, size, hex code]
- **Body:** [font, weight, size, hex code]
- **Accent:** [where the brand red goes, sparingly]
- **Asset references:**
  - Logo: [variant from `resources/brand/rallee/assets/logos/`]
  - Photo (optional): [filename from `assets/photos/` + why this one]

### Layout

[Describe positioning — e.g., "Logo top-left, headline centred at 60% vertical, body below, CTA bottom-right. Generous margins. Editorial whitespace."]

### Canva execution

1. Open Canva → New design → [dimensions]
2. Apply Rallee Brand Kit
3. Drop in the assets above
4. Paste copy
5. Adjust spacing per layout notes

### Alternative angles (optional)

1. [Different framing of same topic]
2. [Another framing]
```

## Brand constraints (always enforced)

- **Editorial layout:** generous whitespace, narrow text columns, restraint over decoration
- **Red is an accent only** — never background, sparingly used (per `visual-style.yaml`)
- **Photography:** lifestyle/editorial, not corporate-stock
- **Voice:** refined, intelligent, warm; Australian without colloquial; "rally" verb used sparingly
- **Type:** Futura for H1, Inter Display for H2-H4 and body

## Chaining

After the brief is generated, the operator can refine with `/design-brief refine: [new direction]` or paste into Canva directly. If the copy needs polishing, chain with `/humanise-text`.

## Canva integration paths

- **Recommended:** Use the claude.ai web Canva Connector (Settings → Connectors → Canva). The brief generated here pastes cleanly into a Canva chat prompt.
- **Power user:** Canva MCP server in Claude Code — set `CANVA_API_TOKEN` in `.env` and install the MCP per https://www.canva.dev/docs/connect/mcp-server/
- **Newest:** Claude Design (claude.ai/design) — text-to-editable-Canva visual, brand-kit-aware
