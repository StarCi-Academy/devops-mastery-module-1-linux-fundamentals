#!/bin/bash
# Convenience runner for the process/service lab (MODE-B disposable container).
# Usage (on the host):
#   docker build -t linux-lab-process-svc:0 .
#   docker run --rm -d --privileged --name linux-lab-process-svc linux-lab-process-svc:0
#   sleep 3
#   docker exec -it linux-lab-process-svc /scripts/run-lab.sh   # or run flows one by one
set -u

echo "==================== Flow 1: process list ===================="
/scripts/00-process-list.sh
echo "==================== Flow 2: background jobs ===================="
/scripts/01-background-jobs.sh
echo "==================== Flow 3: signals ===================="
/scripts/02-signal-sigterm-sigkill.sh
echo "==================== Flow 4: exit codes ===================="
/scripts/03-exit-codes.sh
echo "==================== Flow 5: systemctl + journalctl ===================="
/scripts/04-systemctl-journalctl.sh
echo "==================== Done ===================="
