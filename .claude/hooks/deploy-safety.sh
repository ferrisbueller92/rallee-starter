#!/bin/bash
# .claude/hooks/deploy-safety.sh
# PreToolUse hook — blocks destructive bash commands.
# Fires on: Bash.
#
# Cross-platform: works on macOS, Linux, and Git Bash on Windows.
# Backported from justsorted-workspace v0.1.2.

JQ="$(command -v jq || echo /opt/homebrew/bin/jq)"
INPUT=$(cat)
TOOL_NAME=$(echo "$INPUT" | "$JQ" -r '.tool_name // empty')

if [[ "$TOOL_NAME" != "Bash" ]]; then
  exit 0
fi

CMD=$(echo "$INPUT" | "$JQ" -r '.tool_input.command // empty')

# ─── Outright blocked patterns ────────────────────────────────────────────
BLOCKED_PATTERNS=(
  "rm -rf /"
  "rm -rf ~"
  "rm -rf \$HOME"
  "rm -rf \*"
  ":(){"
  "dd if=/dev/zero"
  "mkfs"
  "> /dev/sda"
  "chmod -R 777 /"
  "sudo rm"
  "Remove-Item -Recurse -Force C:"
  "Remove-Item -Recurse -Force /"
  "Format-Volume"
)

for pattern in "${BLOCKED_PATTERNS[@]}"; do
  if echo "$CMD" | grep -qF "$pattern"; then
    echo "BLOCKED: Destructive command matched pattern '$pattern'" >&2
    echo "If you really intend this, run it yourself outside Claude Code." >&2
    exit 2
  fi
done

# ─── Force-push protection ────────────────────────────────────────────────
if echo "$CMD" | grep -qE "git push.*--force|git push.*-f[^a-zA-Z]"; then
  if ! echo "$CMD" | grep -qF "# FORCE-PUSH-APPROVED"; then
    echo "BLOCKED: Force-push without approval. Re-run with '# FORCE-PUSH-APPROVED' appended if intentional." >&2
    exit 2
  fi
fi

# ─── Hard reset protection ────────────────────────────────────────────────
if echo "$CMD" | grep -qE "git reset --hard"; then
  if ! echo "$CMD" | grep -qF "# HARD-RESET-APPROVED"; then
    echo "BLOCKED: 'git reset --hard' without approval. Re-run with '# HARD-RESET-APPROVED' appended if intentional." >&2
    exit 2
  fi
fi

# ─── Destructive SQL ──────────────────────────────────────────────────────
if echo "$CMD" | grep -qiE "(DROP TABLE|TRUNCATE TABLE|DROP DATABASE|DROP SCHEMA)" ; then
  if ! echo "$CMD" | grep -qF "# DB-DESTROY-APPROVED"; then
    echo "BLOCKED: Destructive SQL without approval. Append '# DB-DESTROY-APPROVED' if intentional." >&2
    exit 2
  fi
fi

# ─── OS-aware soft warning: prefer 'trash' (Mac) or 'Remove-Item' (Win) over 'rm' ──
if echo "$CMD" | grep -qE "^rm |^ rm | rm "; then
  if ! echo "$CMD" | grep -qE "^trash |^rm -i"; then
    OS_TYPE="$(uname -s 2>/dev/null || echo Unknown)"
    case "$OS_TYPE" in
      Darwin)
        echo "NOTE: Consider 'trash' instead of 'rm' (LESSONS.md L02 — Mac). Continuing." >&2
        ;;
      MINGW*|MSYS*|CYGWIN*)
        echo "NOTE: On Windows, consider PowerShell 'Remove-Item' (Recycle Bin) over Git Bash 'rm' (LESSONS.md L02). Continuing." >&2
        ;;
      *)
        echo "NOTE: 'rm' bypasses safe-delete on this system (LESSONS.md L02). Continuing." >&2
        ;;
    esac
  fi
fi

exit 0
