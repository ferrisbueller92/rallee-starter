# LESSONS.md

10 hard-won rules. Each one came from a real failure. Read on session start (`session-state.sh` enforces).

This file grows as you discover new failure modes. Pattern: `TRIGGER` (what went wrong) → `RULE` (what to always/never do).

---

## L01 — Load core files first

**TRIGGER:** Started a session without loading SOUL.md / CLAUDE.md / USER.md. Behaved like generic ChatGPT for 10 minutes. Lost trust.

**RULE:** Read SOUL.md, CLAUDE.md, USER.md, MEMORY.md, LESSONS.md FIRST on every session. The `session-state.sh` hook injects them on UserPromptSubmit — don't skip them.

---

## L02 — Always use `trash`, never `rm`

**TRIGGER:** Deleted a file with `rm`. Needed it back the next day. Gone forever, no Trash recovery.

**RULE:** Use `trash` (from `brew install trash-cli`) for every delete. If uncertain, `mv` to a `.tmp/` folder first. `rm` is reserved for files you have explicitly approved as throwaway.

---

## L03 — Visual-verify: render → READ → describe → only then "done"

**TRIGGER:** Generated an HTML deliverable, screenshot looked OK in tool output, claimed complete. Three days later: the page was broken in production.

**RULE:** Capturing a screenshot ≠ verification. Use the Read tool on the PNG, describe in 1-2 sentences what you actually see, only then mark complete. For audio / video / API outputs: same — actually consume the output, don't trust the metadata.

---

## L04 — Ask before destructive; never assume scope

**TRIGGER:** Ran a "cleanup" that touched 30 files. User intended 3. Recovery took 2 hours.

**RULE:** For any operation that deletes, overwrites, or modifies >3 files at once, surface the scope first ("I'm about to touch these files, OK?"). For destructive ops on shared state (git push, DB writes, sends, posts): always ask.

---

## L05 — 3 retries max, different approach each time

**TRIGGER:** Same error 5 times in a row. Each retry burned tokens. Should have stopped at attempt 2.

**RULE:** 3 attempts max with a different approach each time. After 3: HARD STOP. Report all errors verbatim. Ask the operator for direction. Same error category × 3 across different operations → pause all work.

---

## L06 — Staging-first, never edit production directly

**TRIGGER:** Edited a live site file directly. Bad merge clobbered upstream work. Two hours of recovery.

**RULE:** For any production surface (live website, customer database, public document, deployed app), edit a staging clone first. Render-verify. Sync to production only on explicit "ship it" from the operator.

---

## L07 — Cannot-verify register

**TRIGGER:** Marked an item "ready" when I couldn't actually test it (rendered HTML, audio output, external API response). User found it broken later.

**RULE:** Anything you can't directly verify → log to `.tmp/cannot-verify.md` with: what you did, the exact test the operator needs to run, what "pass" looks like. Never claim "ready" on an unverifiable item.

---

## L08 — Plan before build for 3+ step tasks

**TRIGGER:** Dove into a multi-step build without a plan. Got it 70% right then had to refactor. User frustrated.

**RULE:** For any task that involves 3+ distinct steps or architectural decisions, write the plan first. Verify the plan with the operator. THEN build. Don't dive into multi-step work assuming you understood the ask.

---

## L09 — Never commit secrets

**TRIGGER:** Wrote API credentials to a file that got committed to git. Had to rotate the keys and rewrite history.

**RULE:** Never commit `.env`, `credentials.json`, `token.json`, anything containing `[REDACTED]` or real API keys. The `protect-env.sh` hook blocks reads/writes to these — if it triggers, do NOT find a workaround, fix the underlying intent. Stage specific files (`git add path/to/file`), never `git add .` or `git add -A`.

---

## L10 — End every working session by capturing decisions

**TRIGGER:** Made 3 important decisions during the day. Next morning: forgot the reasoning behind 2 of them. Re-debated for an hour.

**RULE:** End of every working session: run `/session-close`. It prompts you for today's decisions and lessons, saves them to `memory/` and `MEMORY.md`. This is what makes Claude Code different from Claude Chat — compound knowledge across days.

---

*Add new entries below as you discover new failure modes. Format: TRIGGER + RULE + brief context. Anonymise (no names, no client specifics) so the rule travels.*
