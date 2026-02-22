#!/bin/bash
# Cleanup robot browser daemon on session stop.
# Idempotent — safe if robot was never started or isn't installed.
# No stdout to avoid Stop hook interpreting output as a block decision.

ROBOT_CMD=""
if command -v robot >/dev/null 2>&1; then
  ROBOT_CMD="robot"
elif [ -x "${HOME}/go/bin/robot" ]; then
  ROBOT_CMD="${HOME}/go/bin/robot"
elif [ -x "/usr/local/bin/robot" ]; then
  ROBOT_CMD="/usr/local/bin/robot"
fi

if [ -n "$ROBOT_CMD" ]; then
  "$ROBOT_CMD" stop >/dev/null 2>&1 || true
fi

exit 0
