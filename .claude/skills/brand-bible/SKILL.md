---
name: brand-bible
description: Queries the Rallee brand bible (tokens, voice, typography, palette, photography) conversationally. Use when the operator asks about brand colours, voice, fonts, do's/don'ts, or anything in the brand guidelines.
triggers:
  - "brand bible"
  - "brand tokens"
  - "what's our voice"
  - "our palette"
  - "our colours"
  - "our typography"
  - "brand guidelines"
  - "rally voice"
---

# Brand Bible

Conversational interface to `resources/brand/rallee/`. Faster than reading the v4 HTML brand book end-to-end.

## When this fires

User asks anything about the brand — colours, fonts, voice, layout principles, photo style, do's/don'ts, taglines, positioning. Auto-fires on the trigger phrases above.

## Protocol

1. **Identify the question scope** — palette, voice, typography, visual style, audience, or assets?
2. **Read the relevant YAML file** from `resources/brand/rallee/`:
   - Palette / colours → `tokens.json` + `tokens.css`
   - Voice / tone → `voice.yaml`
   - Typography → `typography.yaml`
   - Visual style / layout → `visual-style.yaml`
   - Photography → `manifest.yaml`
   - Positioning / ICP → `identity.yaml` + `audience.yaml`
   - Anything else → `README.md` (the one-page summary)
3. **Quote the exact tokens** (hex codes, font specs, voice rules). Don't paraphrase brand-critical specs.
4. **If the question is design-related**, suggest chaining to `/design-brief`.

## Output format

Concise. The user wants the facts, not a re-summary of the brand book.

```markdown
**[Topic]:** [direct answer with exact specs]

[Optional: 1-2 sentences of context — when this applies, do's/don'ts]

**Source:** `resources/brand/rallee/[file.yaml]`
```

## Brand bible structure

```
resources/brand/rallee/
├── README.md                       (1-page summary)
├── identity.yaml                   (mission, positioning, what we are/aren't)
├── voice.yaml                      (tone, do/don't phrases)
├── tokens.json                     (palette in JSON)
├── tokens.css                      (palette + typography in CSS)
├── typography.yaml                 (fonts, weights, sizes)
├── visual-style.yaml               (editorial layout, photography, restraint)
├── pillars.yaml                    (content pillars)
├── audience.yaml                   (ICPs)
├── manifest.yaml                   (asset → use-case map)
├── claude-design-setup-bundle.md   (paste-ready for Claude Design intake)
└── assets/                         (logos, photos, icons)
```

## When the bible needs updating

If the operator says "the brand has changed" or "update the bible", do NOT silently edit the YAML files. Surface what change is being requested, confirm scope, then edit. Bible updates are load-bearing.
