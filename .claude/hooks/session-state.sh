#!/bin/bash
# .claude/hooks/session-state.sh
# UserPromptSubmit hook — injects core context on the first user prompt of each session.
#
# Loads: SOUL.md, CLAUDE.md, USER.md, MEMORY.md (index only), LESSONS.md
# Plus the most recent daily note (last 24 hours) if it exists.

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$(pwd)}"
SESSION_MARKER="$PROJECT_DIR/.tmp/session-state-loaded"

# Only inject on the first prompt of a session (marker file check)
if [[ -f "$SESSION_MARKER" ]]; then
  # Marker exists — check if it's stale (> 8 hours old)
  MARKER_AGE=$(( $(date +%s) - $(stat -f %m "$SESSION_MARKER" 2>/dev/null || stat -c %Y "$SESSION_MARKER" 2>/dev/null || echo 0) ))
  if (( MARKER_AGE < 28800 )); then
    # Fresh marker — context already injected this session
    exit 0
  fi
fi

mkdir -p "$PROJECT_DIR/.tmp"
touch "$SESSION_MARKER"

# Build the context block
CONTEXT="## Session-start context — auto-loaded by session-state.sh\n\n"

# Core canon files
for f in SOUL.md CLAUDE.md USER.md LESSONS.md; do
  if [[ -f "$PROJECT_DIR/$f" ]]; then
    CONTEXT+="### $f\n\n"
    CONTEXT+="$(cat "$PROJECT_DIR/$f")\n\n"
    CONTEXT+="---\n\n"
  fi
done

# MEMORY.md index only (not all memory files)
if [[ -f "$PROJECT_DIR/MEMORY.md" ]]; then
  CONTEXT+="### MEMORY.md (index)\n\n"
  CONTEXT+="$(cat "$PROJECT_DIR/MEMORY.md")\n\n"
  CONTEXT+="---\n\n"
fi

# Most recent daily note (if any from last 24 hours)
LATEST_DAILY=$(ls -1t "$PROJECT_DIR"/daily/*.md 2>/dev/null | head -1)
if [[ -n "$LATEST_DAILY" ]] && [[ "$(basename "$LATEST_DAILY")" != "template.md" ]]; then
  CONTEXT+="### Most recent daily note: $(basename "$LATEST_DAILY")\n\n"
  CONTEXT+="$(cat "$LATEST_DAILY")\n\n"
  CONTEXT+="---\n\n"
fi

# Emit the context (Claude Code captures stdout as additionalContext)
echo -e "$CONTEXT"
exit 0
