#!/bin/bash
# Flow 3 — send SIGTERM then SIGKILL to a stubborn process.
set -u

# Spawn a process that ignores SIGTERM (trap SIG_IGN)
bash -c 'trap "" SIGTERM; echo "PID=$$"; while true; do sleep 1; done' &
STUBBORN_PID=$!
echo "Spawned PID: $STUBBORN_PID"
sleep 1

# Try SIGTERM first (polite request)
kill -15 "$STUBBORN_PID"
sleep 1

# Check whether the process is still alive
ps -p "$STUBBORN_PID" >/dev/null && echo "Still alive after SIGTERM"

# Must use SIGKILL because the process ignores SIGTERM
kill -9 "$STUBBORN_PID"
sleep 1

# Confirm it is gone
ps -p "$STUBBORN_PID" >/dev/null 2>&1 || echo "Process gone after SIGKILL"

# Use pkill to kill by name (additional practice)
sleep 100 &
sleep 1
pkill -f "sleep 100"
echo "pkill exit code: $?"
