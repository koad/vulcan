#!/usr/bin/env bash
set -euo pipefail
# Vulcan — lives on wonderland (10.10.10.10). This hook connects any machine to his session there.
# Hardcoded host is OK for now; daemon state machine will route this properly when live.
#
# Usage:
#   vulcan                          → portal to Vulcan on wonderland (interactive)
#   PROMPT="build something" vulcan → send task non-interactively, get result
#   echo "build something" | vulcan → send task via stdin

VULCAN_HOST="10.10.10.10"
VULCAN_DIR="\$HOME/.vulcan"
CLAUDE_BIN="\$HOME/.local/bin/claude"

PROMPT="${PROMPT:-}"
if [ -z "$PROMPT" ] && [ ! -t 0 ]; then
  PROMPT="$(cat)"
fi

if [ -n "$PROMPT" ]; then
  # Non-interactive: send task, return only the result
  ssh "$VULCAN_HOST" "cd $VULCAN_DIR && $CLAUDE_BIN --dangerously-skip-permissions -c --output-format=json -p '$PROMPT' 2>/dev/null" \
    | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('result',''))"
else
  # Interactive: open live terminal portal to Vulcan on wonderland
  exec ssh -t "$VULCAN_HOST" "cd $VULCAN_DIR && $CLAUDE_BIN --dangerously-skip-permissions -c"
fi
