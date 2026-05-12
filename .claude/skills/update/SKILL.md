---
name: update
description: Pulls latest from the rallee-starter upstream repo, reads new CHANGELOG entries, and walks the operator through what changed. The "talk to your code about updates" capability.
triggers:
  - "any updates"
  - "pull latest"
  - "what's new"
  - "whats new"
  - "update from upstream"
  - "check for updates"
  - "git pull"
---

# Update

Pulls upstream improvements and explains what changed. The other half of the "talk to your code" loop.

## When this fires

Operator asks if there are updates. Auto-fires on trigger phrases above. Manual: `/update`.

## Protocol

1. **Check current state:**
   - Read `VERSION` (current version)
   - Run `git rev-parse HEAD` (current commit)
   - Run `git fetch origin main` to get latest refs
2. **Compare:**
   - Run `git log HEAD..origin/main --oneline` to see incoming commits
   - If zero commits → "You're up to date on v[X]. Nothing new."
3. **If there are updates, preview before pulling:**
   - Show the operator: "There are [N] new commits. Latest CHANGELOG version is [Y]. Want me to pull and walk you through what's new?"
   - Wait for confirmation before `git pull`.
4. **Pull:**
   - Run `git pull origin main`
   - Read the new CHANGELOG entries (the section above the previous version)
5. **Explain:**
   - Walk through each new entry conversationally
   - Highlight any breaking changes or new setup steps
   - Surface any new skills or hooks that fired
6. **Update local SHIPPED.md if changed** — re-read so subsequent `/whats-shipped` calls reflect the new state.

## Output format

```markdown
## Update — rallee-starter

**You were on:** v[old version] (commit [hash])
**Latest:** v[new version] (commit [hash])
**Commits pulled:** [N]

### What's new

**v[X.Y.Z]** — [date] — [headline]

- [Change 1] — [why it matters for you]
- [Change 2] — ...

[If breaking changes:]
**⚠️ Action needed:**
- [What the operator needs to do]

### What's the same

[Anything that didn't change but might be worth re-mentioning, e.g., "your /critique skill is unchanged"]
```

## Safety

- Never `git push` from this skill — pull only
- If there are local uncommitted changes, surface them before pulling: "You have local changes — commit or stash before I pull?"
- If pull fails (merge conflict, etc.), don't try to auto-resolve. Report the conflict and ask the operator how to handle.

## Upstream repo

The upstream is `github.com/ferrisbueller92/rallee-starter` on the `main` branch. This is set as `origin` when the operator clones via `gh repo clone`.

If `origin` isn't set (operator downloaded zip instead of cloning), surface that and offer to set it: `git remote add origin https://github.com/ferrisbueller92/rallee-starter.git`.
