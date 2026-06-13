#!/bin/bash
# Flow 2 — background jobs and control (jobs/fg/bg/Ctrl-Z).
# Job control (set -m) is enabled so %1 and bg/fg work in a non-interactive script.
set -m

# Spawn a background job (prints a counter every second)
bash -c 'i=0; while true; do echo "count $i"; i=$((i+1)); sleep 1; done' &
sleep 2

echo "### jobs (running)"
jobs

echo "### suspend via SIGSTOP (equivalent to Ctrl-Z), then jobs"
kill -STOP %1
sleep 1
jobs

echo "### resume in background (bg %1), then jobs"
bg %1
sleep 1
jobs

echo "### kill the job"
kill %1
sleep 1
jobs
echo "no jobs remaining: $?"
