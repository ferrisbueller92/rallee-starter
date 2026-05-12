# CLAUDE.md

Guide for Claude Code working in this repo. Read this on the first prompt of every session — the `session-state.sh` hook enforces this.

---

## Core files (read in order)

| File | Purpose |
|------|---------|
| `SOUL.md` | Persona, hard limits, 7 quality gates, anti-patterns |
| `CLAUDE.md` | This file — routing, conventions, environment |
| `USER.md` | The operator's context, preferences, locale |
| `MEMORY.md` | Long-term knowledge, decisions, incidents |
| `LESSONS.md` | 10 hard-won rules that prevent common failures |
| `SHIPPED.md` | Inventory of skills, hooks, tools (read by `/whats-shipped`) |

---

## Before starting any task

1. Read `SOUL.md` (if not already this session)
2. Scan `LESSONS.md` for rules relevant to this task
3. Search `MEMORY.md` for past decisions on this topic
4. Use the skill router (`skill-rules.json`) — match the user's prompt against trigger phrases before reaching for raw tool use
5. For 3+ step tasks, plan FIRST, verify with user, THEN implement
6. Never fabricate specifics (company names, numbers, prices). Use `[TBD]` for unknowns

---

## Skill routing

Skills live in `.claude/skills/` — each has a `SKILL.md` with YAML frontmatter listing trigger phrases. The `skill-router.sh` hook pattern-matches every prompt against `skill-rules.json`.

**Chaining rules:**
- `humanise-text` runs on every outbound deliverable (LinkedIn DM, email, social post)
- `vault-search` runs first when the question references past work ("have we written about", "what did we decide")
- `critique` is opt-in — fires only on explicit "critique this" / "review this"
- `session-close` runs only on explicit invocation

**Full skill list:** see `SHIPPED.md` or ask `/whats-shipped`.

---

## Memory protocol

Memory lives in `memory/`. Index at `MEMORY.md`. Four types:

| Type | When to save | Example |
|------|--------------|---------|
| `user` | Operator's role, preferences, knowledge | "Bri runs Rallee, recruitment-focused, prefers terse responses" |
| `feedback` | Corrections + confirmations of approach | "Don't use emojis in LinkedIn DMs — feels off-brand" |
| `project` | Active work, decisions, deadlines | "Q2 focus: 5 new placements in fintech sector" |
| `reference` | Where info lives in external systems | "Candidate database in Airtable workspace 'RalleeTalent'" |

**File format:**
```markdown
---
name: short-kebab-case-slug
description: one-line summary for future relevance check
metadata:
  type: user | feedback | project | reference
---

Content here. Link related memories with [[other-name]].
```

Add a pointer in `MEMORY.md` index (one line, under 150 chars).

**Decay rule:** memories about external state (people, prices, schedules) go stale. Verify before acting on a memory; update if stale.

---

## Delivery

For now, deliverables land in `deliverables/` folder (you create on first use) and via stdout. Multi-channel delivery (Gmail, Telegram, GDrive) is wired but disabled until you OAuth those connectors.

When you do connect more channels later, the pattern is:

| Content | Channels |
|---------|----------|
| Brief / summary | stdout + (optionally) email |
| Report / analysis | save to `deliverables/` |
| Time-sensitive alert | Telegram (when connected) |

---

## Git convention

```
cos: <action> - <description>

# examples
cos: new memory - bri profile
cos: update brand bible - voice tokens
cos: complete task - linkedin draft
```

**Safety rules (hard):**
- Never `git push --force` without explicit operator approval
- Never `--no-verify` on commits unless explicitly requested
- Stage specific files, not `git add .` (avoids accidentally committing `.env` or credentials)
- Co-author tag on AI-assisted work: `Co-Authored-By: Claude <noreply@anthropic.com>`

---

## Coding conventions

- Python tools: `main()` with docstring, CLI args via `argparse`, exit code 0/non-zero
- Output files for the user: `deliverables/`, `resources/`, or named project folders. Not `.tmp/` (that's machine-only)
- HTML deliverables include a visible "Last updated: YYYY-MM-DD" tag
- Never overwrite a workflow / production file without asking

---

## The 7 quality gates (from SOUL.md, must pass before "done")

1. **Tested** — actually verified it works, not "should work"
2. **Error-checked** — visible errors handled or surfaced explicitly
3. **Production-grade** — no placeholders, no `[TBD]` left in shipped artefact
4. **Complete scope** — all asks from the prompt addressed
5. **Format correct** — HTML deliverables include the date tag, JSON validates, etc.
6. **Tracking updated** — MEMORY.md / daily note / changelog updated if relevant
7. **Card quality** — if a task card was created, has 7 metadata fields minimum

If any gate fails: do not mark complete. Log to `.tmp/cannot-verify.md` and report exactly what the user needs to test.

---

## Environment

- **Platform:** macOS (assumed). Adjust for Windows/Linux if needed.
- **Shell:** zsh
- **Python:** 3.10+ recommended
- **Claude Code:** desktop app or web (claude.ai/code)

---

## Security

Never commit: `.env`, `credentials.json`, `token.json`, anything with `[REDACTED]` or real API keys. The `protect-env.sh` hook blocks reads/writes to these. The `deploy-safety.sh` hook blocks `rm -rf`, `git push --force`, destructive SQL.

---

**Version:** 0.1.0 · **Last updated:** 2026-05-12
