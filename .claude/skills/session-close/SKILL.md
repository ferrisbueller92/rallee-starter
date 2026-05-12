---
name: session-close
description: End-of-working-session capture. Prompts for today's decisions and lessons, saves to memory/ and MEMORY.md, optionally appends to today's daily note. The compound-knowledge habit that makes tomorrow better than today.
triggers:
  - "session close"
  - "wrap up"
  - "capture today"
  - "end session"
  - "save today's decisions"
---

# Session Close

Compound knowledge capture. Runs at the end of a working session.

## When this fires

Operator explicitly invokes — never auto-fires. Should be a deliberate ritual at the end of each working session.

Manual: `/session-close`.

## Protocol

1. **Review the session.** Read recent git log entries + edited files in this session. Summarise what got done.
2. **Prompt for decisions.** Ask: "Any decisions you made today worth saving?"
3. **Prompt for lessons.** Ask: "Anything you learned that you'd want to remember as a rule? (Format: trigger → rule.)"
4. **Prompt for blockers / carry-forward.** "Anything blocked or carrying into tomorrow?"
5. **Save:**
   - **Decisions** → new file in `memory/` as `project_<topic>_<date>.md` + one-line entry in MEMORY.md index
   - **Lessons** → append to LESSONS.md with next L## number
   - **Daily note** → `daily/YYYY-MM-DD.md`, append session summary + carry-forward
6. **Confirm what was saved** — show the operator the files updated.

## Output format

```markdown
## Session close — [date]

**Session summary:** [2-3 sentences on what got done]

### Decisions saved
- `memory/project_<topic>_<date>.md` — [one-line description]

### Lessons added
- L[NN] in LESSONS.md — [trigger / rule one-liner]

### Daily note
- `daily/YYYY-MM-DD.md` updated

### Carry forward (open / blocked)
- [item 1]
- [item 2]
```

## Memory file template

```markdown
---
name: project-<topic>-<date>
description: [one-line summary]
metadata:
  type: project
---

**Decision:** [what was decided]

**Why:** [reasoning]

**How to apply:** [when this kicks in going forward]

**Related:** [[other-memory-name]] (if applicable)
```

## Lesson template (for LESSONS.md)

```markdown
## L[NN] — [short title]

**TRIGGER:** [what went wrong / what was the prompt for this rule]

**RULE:** [what to always/never do]
```

## What this skill DOESN'T do

- Doesn't auto-decide what's "important enough" — the operator chooses
- Doesn't post to external systems (Telegram, email) unless explicitly asked
- Doesn't archive — saved memory stays in `memory/` indefinitely (decay-detection happens on read, not at save time)
