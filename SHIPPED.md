# SHIPPED — what's in this repo

**Version:** 0.1.0
**Last update:** 2026-05-12
**Maintainer:** Just Sorted (Dave + SJ)

This file is the canonical inventory. The `/whats-shipped` skill reads it and explains components conversationally.

---

## Brain files (5)

| File | Purpose |
|---|---|
| `CLAUDE.md` | Master routing — which skill fires on which trigger, chaining rules, conventions |
| `SOUL.md` | Persona, hard limits, 7 quality gates, anti-patterns |
| `USER.md` | Your profile (you fill turn 1) |
| `MEMORY.md` | Your persistent memory index (grows as you work) |
| `LESSONS.md` | 10 hard-won rules from production failures |

---

## Skills (9)

| Skill | Trigger phrases | What it does |
|---|---|---|
| `/research-analyst` | "research", "deep dive", "analyse", "what's the landscape" | Multi-source synthesis with citations |
| `/design-brief` | "design brief", "Canva brief", "post about", "carousel about" | Generates structured Canva-ready brief from brand tokens |
| `/brand-bible` | "brand bible", "what's our voice", "palette", "brand tokens" | Queries your `resources/brand/rallee/` tokens conversationally |
| `/humanise-text` | "humanise", "make this sound natural", "polish", "strip AI tone" | Removes 132+ AI patterns |
| `/critique` | "critique", "review", "roast", "what's wrong with this" | Harsh adversarial review, scores 1-20 |
| `/vault-search` | "find anything I've written about", "semantic search", "have we covered" | Semantic search across your vault |
| `/session-close` | "session close", "wrap up", "capture today", "end session" | Saves decisions + lessons to MEMORY.md and LESSONS.md |
| `/whats-shipped` | "what's in this repo", "what do I have", "inventory" | Reads this file, explains each component |
| `/update` | "any updates", "pull latest", "what's new" | Runs `git pull origin main` + walks new CHANGELOG entries |

---

## Hooks (3)

| Hook | Fires | What it blocks/does |
|---|---|---|
| `protect-env.sh` | PreToolUse | Blocks reads/writes to `.env`, `credentials.json`, `token.json`, anything `[REDACTED]` |
| `deploy-safety.sh` | PreToolUse | Blocks `rm -rf`, `git push --force`, destructive SQL |
| `session-state.sh` | UserPromptSubmit | Loads `USER.md` + recent `daily/` notes on first prompt of every session |

---

## Tools (1)

| Tool | Purpose | Usage |
|---|---|---|
| `tools/vault_search.py` | Semantic search across your folder | `python tools/vault_search.py "your query"` (or via `/vault-search` skill) |

---

## Brand bible (`resources/brand/rallee/`)

Already token-ised from the Rallee Brand Guide v4. Claude reads these on every brand-related prompt.

| File | Contains |
|---|---|
| `README.md` | One-page bible summary Claude uses as primary context |
| `identity.yaml` | Positioning, mission, what we are/aren't |
| `voice.yaml` | Tone descriptors, do/don't phrases, anti-patterns |
| `tokens.json` | Palette hex codes, RGB values (5 named tokens) |
| `tokens.css` | CSS custom properties version of palette + typography |
| `typography.yaml` | Font families, weights, sizes, tracking |
| `visual-style.yaml` | Editorial layout principles, photography direction |
| `pillars.yaml` | Content pillars |
| `audience.yaml` | ICPs and what they care about |
| `manifest.yaml` | Every asset → use-case map |
| `claude-design-setup-bundle.md` | Paste-ready inputs for Claude Design intake |
| `assets/logos/` | SVG and PNG logos |
| `assets/photos/` | Brand photography (Bree portraits, mood, etc.) |
| `assets/icons/` | Icon set (when populated) |

---

## Configuration

| File | Purpose |
|---|---|
| `.claude/settings.json` | Skill paths, hook registrations, MCP server refs |
| `.claude/skill-rules.json` | Skill trigger-phrase routing rules |
| `env.example` | Every env var you might want, commented (copy to `.env` and fill in) |
| `.gitignore` | Protects `.env`, credentials, `.tmp/`, Python cache |
| `requirements.txt` | Python deps for `tools/` |

---

## Demo seed (`seed/`)

One pre-written file so the vault-search demo has something to find on day one:
- `au-recruitment-market-2026-q1.md` — sample market notes

---

## Empty folders (you populate)

| Folder | What goes here |
|---|---|
| `memory/` | Your decisions, feedback, project memories, references |
| `daily/` | Daily notes (`YYYY-MM-DD.md` format, template in `daily/template.md`) |

---

## Counts

```
Skills:    9
Hooks:     3
Tools:     1
Brain:     5 .md files
Brand:    13 files in resources/brand/rallee/
Total:    ~32 shipped files + dependencies
```
