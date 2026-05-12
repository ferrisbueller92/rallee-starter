# MEMORY.md

Long-term knowledge index. Populates as you work. Each entry = one line, under 150 chars: `- [Title](file.md) — one-line hook`.

Memory files live in `memory/`. Read CLAUDE.md → "Memory protocol" for the full spec.

---

## Index

_Empty. Your first memory will land here. Examples of what you might capture:_

```
- [User profile · Bri Hardie · Rallee founder](user_bri-hardie.md) — Sydney recruiter, terse comms, no emojis in DMs
- [Feedback · Skip generic LinkedIn templates](feedback_no-linkedin-templates.md) — Bri prefers handwritten-feeling DMs
- [Project · Q2 fintech placements](project_q2-fintech.md) — 5 placement target, deadline 30 June 2026
- [Reference · Candidate DB lives in Airtable](reference_airtable-talent.md) — Workspace "RalleeTalent", base "Active Candidates"
```

---

## Four memory types

| Type | When to save |
|------|--------------|
| `user` | Operator's role, preferences, knowledge |
| `feedback` | Corrections + confirmations of approach (include WHY) |
| `project` | Active work, decisions, deadlines |
| `reference` | Where info lives in external systems |

## What NOT to save

- Code patterns / architecture (already in the code)
- Git history / who-changed-what (`git log` is authoritative)
- Anything already in CLAUDE.md, USER.md, or LESSONS.md
- Ephemeral task state (use daily notes for that)

---

## Memory file template

```markdown
---
name: short-kebab-case-slug
description: one-line summary used to decide relevance in future conversations
metadata:
  type: user | feedback | project | reference
---

Lead with the rule/fact, then:

**Why:** the reason — often a past incident or strong preference
**How to apply:** when / where this kicks in

Link related entries with [[other-slug]].
```
