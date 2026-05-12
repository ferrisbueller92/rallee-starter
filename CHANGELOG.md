# Changelog

All notable changes to this repo are documented here. Each version is a semver tag; the `/update` skill reads new entries and walks you through them.

## [0.1.0] — 2026-05-12 — Initial release

### Shipped
- 5 brain files (CLAUDE, SOUL, USER, MEMORY, LESSONS)
- 9 skills (research-analyst, design-brief, brand-bible, humanise-text, critique, vault-search, session-close, whats-shipped, update)
- 3 hooks (protect-env, deploy-safety, session-state)
- 1 tool (vault_search.py)
- Rallee brand bible staged in `resources/brand/rallee/` with tokens, voice, typography, palette, photography manifest, assets
- 1 seed file for vault-search demo (AU recruitment market 2026 Q1)
- `env.example`, `.gitignore`, `requirements.txt`
- `SHIPPED.md` manifest + `/whats-shipped` skill that reads it

### Notes
- This is v0.1 — the goal is "Bri running by tomorrow." More features ship as she identifies what she actually uses.
- All Just Sorted, NAH, and personal Dave-specific content has been stripped from the upstream Snips workspace.
- License: MIT for the architecture. Brand bible content remains Rallee's IP.

---

## [0.1.1] — 2026-05-12 — Cross-platform improvements

### Improved (backported from sibling justsorted-workspace)
- `session-state.sh` hook — replaced inline stat fallback with explicit `uname -s` OS detection (Darwin/Linux/MINGW*/MSYS*/CYGWIN*). Cleaner, more debuggable, works correctly on Git Bash on Windows in addition to Mac/Linux.
- `deploy-safety.sh` hook — added Windows-specific destructive command blocks (Remove-Item -Recurse -Force, Format-Volume) + OS-aware soft-warnings on `rm` use (Mac suggests `trash`, Windows suggests PowerShell `Remove-Item`).
- `BUILD-LOG.md` added — methodology artefact documenting v0.1.0 retroactively + recording v0.1.1 improvements.

### Why these changes
The sibling `justsorted-workspace` repo (SJ's environment, Windows-targeted) surfaced the cross-platform gaps in v0.1.0. Patches flow back to keep both repos in parity on infrastructure.

### What's the same
- All 9 skills unchanged
- 1 tool unchanged
- Rallee brand bible unchanged
- Seed file unchanged
- The "one-pager" simplicity preserved

## [Unreleased]

_Track planned changes here. Each push to main becomes a versioned entry above._
