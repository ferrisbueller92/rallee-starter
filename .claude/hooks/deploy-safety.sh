#!/bin/bash
# .claude/hooks/deploy-safety.sh
# PreToolUse hook — blocks destructive bash commands.
# Fires on: Bash.

JQ="$(command -v jq || echo /opt/homebrew/bin/jq)"
INPUT=$(cat)
TOOL_NAME=$(echo "$INPUT" | "$JQ" -r '.tool_name // empty')

if [[ "$TOOL_NAME" != "Bash" ]]; then
  exit 0
fi

CMD=$(echo "$INPUT" | "$JQ" -r '.tool_input.command // empty')

# Destructive patterns — block outright
BLOCKED_PATTERNS=(
  "rm -rf /"
  "rm -rf ~"
  "rm -rf \$HOME"
  "rm -rf \*"
  ":(){"                          # fork bomb
  "dd if=/dev/zero"
  "mkfs"
  "> /dev/sda"
  "chmod -R 777 /"
  "sudo rm"
)

# Pattern-match destructive commands
for pattern in "${BLOCKED_PATTERNS[@]}"; do
  if echo "$CMD" | grep -qF "$pattern"; then
    echo "BLOCKED: Destructive command matched pattern '$pattern'" >&2
    echo "If you really intend this, run it yourself outside Claude Code." >&2
    exit 2
  fi
done

# Force-push protection — require explicit override comment
if echo "$CMD" | grep -qE "git push.*--force|git push.*-f[^a-zA-Z]"; then
  if ! echo "$CMD" | grep -qF "# FORCE-PUSH-APPROVED"; then
    echo "BLOCKED: Force-push without approval. Re-run with '# FORCE-PUSH-APPROVED' appended if intentional." >&2
    exit 2
  fi
fi

# Reset --hard protection
if echo "$CMD" | grep -qE "git reset --hard"; then
  if ! echo "$CMD" | grep -qF "# HARD-RESET-APPROVED"; then
    echo "BLOCKED: 'git reset --hard' without approval. Re-run with '# HARD-RESET-APPROVED' appended if intentional." >&2
    exit 2
  fi
fi

# DROP / TRUNCATE on SQL
if echo "$CMD" | grep -qiE "(DROP TABLE|TRUNCATE TABLE|DROP DATABASE)" ; then
  if ! echo "$CMD" | grep -qF "# DB-DESTROY-APPROVED"; then
    echo "BLOCKED: Destructive SQL without approval. Append '# DB-DESTROY-APPROVED' if intentional." >&2
    exit 2
  fi
fi

# Suggest 'trash' over 'rm' for any rm command
if echo "$CMD" | grep -qE "^rm |^ rm | rm "; then
  if ! echo "$CMD" | grep -qE "^trash |^rm -i"; then
    # Don't block — just warn via stderr (non-blocking)
    echo "NOTE: Consider 'trash' instead of 'rm' (LESSONS.md L02). Continuing." >&2
  fi
fi

exit 0
