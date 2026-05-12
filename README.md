# Rallee · Claude Code Starter

> Built by **Just Sorted** — a Claude Code workspace pre-configured with persistent memory, auto-routing skills, brand-aware design briefs, and the safety rails of 100 days of production refinement.

**For:** Bri Hardie at Rallee — moving from Claude Chat to Claude Code with the operational architecture that makes the difference.

---

## What's in the box (the one-pager)

```
4 brain files     CLAUDE.md · SOUL.md · USER.md · MEMORY.md · LESSONS.md
9 skills          /research-analyst   research candidates, clients, markets
                  /design-brief        generate Canva-ready briefs from your brand
                  /brand-bible         query your tokens, voice, palette, assets
                  /humanise-text       strip AI-isms from any draft
                  /critique            harsh review of a doc, email, proposal
                  /vault-search        semantic search across your vault
                  /session-close       capture today's decisions and lessons
                  /whats-shipped       inventory of what's in this repo
                  /update              pull latest from upstream + walk you through what's new
3 hooks           protect-env (blocks .env reads) · deploy-safety (blocks rm -rf, force-push)
                  session-state (loads your context on first prompt every session)
1 tool            vault_search.py — semantic search over your folder
1 brand bible     resources/brand/rallee/ — tokens, voice, photos, manifest
```

---

## First 30 minutes (Dave walks you through this live)

| # | Step | What happens |
|---|---|---|
| 1 | `brew install gh trash-cli` | GitHub CLI + safe `rm` replacement |
| 2 | `gh auth login` | Browser opens, you sign in to GitHub |
| 3 | `gh repo clone ferrisbueller92/rallee-starter ~/rallee-vault` | Folder appears on your Mac |
| 4 | `cd ~/rallee-vault && pip install -r requirements.txt` | Python deps for vault search |
| 4b | `cp .claude/settings.example.json .claude/settings.json && cp env.example .env` | Activate config + create local env file (both gitignored) |
| 5 | Open the folder in Claude Code (File → Open Folder) | Claude loads `.claude/settings.json`, sees skills + hooks |
| 6 | Type: *"I'm Bri at Rallee — [tell it about you and your business]"* | USER.md populates. Claude remembers. |
| 7 | Type: *"What's in this repo?"* | `/whats-shipped` fires. You see your toolkit. |
| 8 | Type: *"Pull my brand bible — what does it say about voice?"* | `/brand-bible` fires. Voice tokens appear. |
| 9 | Type: *"Need a LinkedIn post about [topic]. Square format."* | `/design-brief` returns copy + hex codes + layout. |
| 10 | Type: *"Find any notes I've written about AU recruitment market."* | `/vault-search` finds your seed file. |
| 11 | Type: *"Critique this:"* then paste a recent DM you sent | `/critique` returns harsh review. |
| 12 | Type: *"Session close. Capture today."* | MEMORY.md grows. Tomorrow Claude remembers this meeting. |

---

## Connecting Canva

**Path 1 — claude.ai web (easiest, 2 min):**
Open claude.ai → Settings → Connectors → Canva → OAuth. Done. From now on you can prompt Canva designs from claude.ai directly, with your Brand Kit applied automatically.

**Path 2 — Claude Code (in this repo):**
Use `/design-brief` to generate structured briefs. Paste into Canva, apply your Rallee Brand Kit, Magic Design fills the rest. Iteration loop is fast because the brief regenerates in seconds.

**Path 3 — Claude Design (newer, optional):**
Anthropic Labs + Canva. Text-to-editable-Canva visuals without opening Canva. Try `claude.ai/design` if you want to test it.

---

## Connecting Gmail, Calendar, Drive

In Claude Code → MCP settings → Connect Gmail / Calendar / Drive → OAuth consent. Your tokens stay on your Mac, never touch Just Sorted infrastructure.

---

## When you want more

```
"What's in my repo?"              →  /whats-shipped reads SHIPPED.md
"Any updates from Just Sorted?"   →  /update runs git pull + walks new entries
```

We push improvements weekly. You run `/update`, Claude explains what changed.

---

## When something breaks

Telegram Dave. He's on call for the first 30 days.

---

## License

MIT for the architecture. Your data, your brand, your repo — none of it leaves your machine.

---

*Built on the [Snips operating model](https://github.com/ferrisbueller92/snips-second-brain) — 100 days of production refinement, distilled.*
