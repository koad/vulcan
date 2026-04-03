#!/usr/bin/env bash
set -euo pipefail
# Vulcan — interactive or prompt-driven
# Usage: vulcan                          → interactive Claude Code session
#        PROMPT="build something" vulcan → non-interactive, identity + prompt
#        echo "build something" | vulcan → non-interactive, stdin
#
# CWD is preserved from call site — Vulcan has access to both his entity dir
# and wherever he was invoked from.

ENTITY_DIR="$HOME/.vulcan"
IDENTITY="$ENTITY_DIR/memories/001-identity.md"
CALL_DIR="${CWD:-$PWD}"  # koad-io exports CWD; fallback to PWD

PROMPT="${PROMPT:-}"
if [ -z "$PROMPT" ] && [ ! -t 0 ]; then
  PROMPT="$(cat)"
fi

cd "$ENTITY_DIR"

if [ -n "$PROMPT" ]; then
  exec claude -p "$(cat "$IDENTITY")

Working directory context: $CALL_DIR

$PROMPT" --add-dir "$CALL_DIR"
else
  exec claude . --model sonnet --add-dir "$CALL_DIR"
fi
