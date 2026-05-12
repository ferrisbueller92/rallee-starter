---
name: humanise-text
description: Strips AI-isms from any draft. Removes corporate buzzwords, em-dash overuse, "delve into", "leverage", "comprehensive", "robust", etc. Applies operator's voice profile from voice.yaml.
triggers:
  - "humanise"
  - "humanize"
  - "polish this"
  - "strip ai tone"
  - "make this sound natural"
  - "fix the voice"
---

# Humanise Text

Final polish layer. Applied to any outbound text before it gets sent.

## When this fires

User asks to humanise / polish / strip AI tone, OR explicitly chains it after another skill. Should auto-chain on outbound deliverables (LinkedIn DMs, emails, social posts, proposals) — see CLAUDE.md chaining rules.

Manual: `/humanise-text` then paste text.

## Protocol

1. **Read the operator's voice profile** from `resources/brand/rallee/voice.yaml`.
2. **Identify AI patterns** in the input — see the pattern list below.
3. **Rewrite, preserving meaning** — never invent new information.
4. **Flag uncertain rewrites** — if a sentence could mean two things, ask.

## Patterns to strip

**Buzzwords / corporate jargon:**
- leverage, impactful, robust, seamless, synergy, holistic, scalable solutions, best-in-class, world-class, cutting-edge, paradigm shift, ecosystem, journey (as in "customer journey")
- Substitute concrete verbs: leverage → use, impactful → matters, seamless → smooth, robust → solid

**AI tell-tale phrases:**
- "delve into", "dive into", "embark on", "navigate the landscape", "in today's fast-paced", "in the realm of", "it's important to note that", "comprehensive overview", "multifaceted approach", "tapestry of"
- "Furthermore", "Moreover", "Additionally" overused as transitions

**Structural tells:**
- 3-bullet symmetrical lists when 2 or 4 would be honest
- Sentence parallelism that's too clean
- "Not just X, but Y" repeated
- Em-dash overuse (one per paragraph max)
- Headers + bullets where prose would flow better

**Closing tells:**
- "I hope this helps!"
- "Let me know if you have any questions"
- "Don't hesitate to reach out"
- "Looking forward to..."

## Voice profile application

After AI-strip, apply the operator's voice from `voice.yaml`. Rallee's voice (from the bible):
- Refined, intelligent, warm
- Australian without being colloquial
- Curated language: "we vet every candidate" framing
- "Rally" as verb used sparingly (not 4+ times per page)
- Anti-pattern: LinkedIn-template-prose, corporate-stiff, high-volume-body-shop tone

## Output format

Return ONLY the rewritten text. No commentary about what you changed unless the operator explicitly asks for a diff.

If you stripped >30% of the original, mention briefly: "Cut heavy — [N] sentences removed for tightness."

## What this skill is NOT

- Not a translator. Don't change meaning.
- Not a fact-checker. If the input claims something false, flag it but don't invent corrections.
- Not a length-adder. If anything, output should be ≤ input length.
