#!/bin/bash
# .claude/hooks/protect-env.sh
# PreToolUse hook — blocks access to sensitive credential files.
# Fires on: Read, Edit, Write, Bash.

JQ="$(command -v jq || echo /opt/homebrew/bin/jq)"
INPUT=$(cat)
TOOL_NAME=$(echo "$INPUT" | "$JQ" -r '.tool_name // empty')

# Protected file patterns
PROTECTED=(".env" "credentials.json" "token.json" ".claude/settings.json" ".mcp.json")

# Exempt suffixes — these template/example files are safe to read/write
EXEMPT_SUFFIXES=(".example" ".template" ".sample")

is_exempt() {
  local path="$1"
  for suffix in "${EXEMPT_SUFFIXES[@]}"; do
    if [[ "$path" == *"$suffix" ]] || [[ "$path" == *"$suffix"* ]]; then
      return 0
    fi
  done
  return 1
}

check_path() {
  local path="$1"
  if is_exempt "$path"; then return 1; fi
  for pattern in "${PROTECTED[@]}"; do
    case "$path" in
      *"$pattern"*) return 0 ;;
    esac
  done
  return 1
}

case "$TOOL_NAME" in
  Bash)
    CMD=$(echo "$INPUT" | "$JQ" -r '.tool_input.command // empty')
    for pattern in "${PROTECTED[@]}"; do
      if echo "$CMD" | grep -qF "$pattern"; then
        # Allow .example / .template / .sample references in commands
        if echo "$CMD" | grep -qE "$pattern\.(example|template|sample)"; then
          continue
        fi
        echo "BLOCKED: Command references protected file matching '$pattern'" >&2
        exit 2
      fi
    done
    ;;
  Read|Edit|Write)
    FILE_PATH=$(echo "$INPUT" | "$JQ" -r '.tool_input.file_path // empty')
    if check_path "$FILE_PATH"; then
      echo "BLOCKED: Cannot access protected file: $FILE_PATH" >&2
      echo "If you intended to write a template, use the .example or .template suffix." >&2
      exit 2
    fi
    ;;
esac

exit 0
