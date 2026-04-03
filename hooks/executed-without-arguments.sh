#!/usr/bin/env bash
set -euo pipefail
# Vulcan — interactive or prompt-driven
# Usage: vulcan                          → interactive Claude Code session
#        PROMPT="build something" vulcan → non-interactive, identity + prompt
#        echo "build something" | vulcan → non-interactive, stdin

IDENTITY="$HOME/.vulcan/memories/001-identity.md"

PROMPT="${PROMPT:-}"
if [ -z "$PROMPT" ] && [ ! -t 0 ]; then
  PROMPT="$(cat)"
fi

cd "$HOME/.vulcan"

if [ -n "$PROMPT" ]; then
  exec opencode run --model opencode/big-pickle "$(cat "$IDENTITY")

$PROMPT"
else
  exec claude . --model sonnet
fi
