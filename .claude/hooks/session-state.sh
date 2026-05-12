#!/bin/bash
# .claude/hooks/session-state.sh
# UserPromptSubmit hook — injects core context on the first user prompt of each session.
#
# Loads: SOUL.md, CLAUDE.md, USER.md, LESSONS.md, MEMORY.md (index only)
# Plus the most recent daily note if it exists.
#
# Cross-platform: works on macOS, Linux, and Git Bash on Windows.
# Detects OS via `uname -s` and adapts `stat` invocation accordingly.
# Backported from justsorted-workspace v0.1.1.

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$(pwd)}"
SESSION_MARKER="$PROJECT_DIR/.tmp/session-state-loaded"

# OS detection for stat command differences
OS_TYPE="$(uname -s 2>/dev/null || echo Unknown)"

get_file_mtime() {
  local file="$1"
  case "$OS_TYPE" in
    Darwin)
      stat -f %m "$file" 2>/dev/null
      ;;
    Linux|MINGW*|MSYS*|CYGWIN*)
      stat -c %Y "$file" 2>/dev/null
      ;;
    *)
      echo 0
      ;;
  esac
}

# Only inject on the first prompt of a session (marker file check)
if [[ -f "$SESSION_MARKER" ]]; then
  MARKER_MTIME=$(get_file_mtime "$SESSION_MARKER")
  NOW=$(date +%s)
  MARKER_AGE=$(( NOW - MARKER_MTIME ))
  if (( MARKER_AGE < 28800 )); then
    exit 0
  fi
fi

mkdir -p "$PROJECT_DIR/.tmp"
touch "$SESSION_MARKER"

CONTEXT="## Session-start context — auto-loaded by session-state.sh\n\n"

for f in SOUL.md CLAUDE.md USER.md LESSONS.md; do
  if [[ -f "$PROJECT_DIR/$f" ]]; then
    CONTEXT+="### $f\n\n"
    CONTEXT+="$(cat "$PROJECT_DIR/$f")\n\n"
    CONTEXT+="---\n\n"
  fi
done

if [[ -f "$PROJECT_DIR/MEMORY.md" ]]; then
  CONTEXT+="### MEMORY.md (index)\n\n"
  CONTEXT+="$(cat "$PROJECT_DIR/MEMORY.md")\n\n"
  CONTEXT+="---\n\n"
fi

if [[ -d "$PROJECT_DIR/daily" ]]; then
  LATEST_DAILY=$(ls -1t "$PROJECT_DIR"/daily/*.md 2>/dev/null | grep -v template.md | head -1)
  if [[ -n "$LATEST_DAILY" ]]; then
    CONTEXT+="### Most recent daily note: $(basename "$LATEST_DAILY")\n\n"
    CONTEXT+="$(cat "$LATEST_DAILY")\n\n"
    CONTEXT+="---\n\n"
  fi
fi

printf "%b" "$CONTEXT"
exit 0
