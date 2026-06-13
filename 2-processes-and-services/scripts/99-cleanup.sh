#!/bin/bash
# Cleanup — stop/disable the lab unit inside the container (host cleanup is docker rm).
systemctl stop sample-worker 2>/dev/null || true
systemctl disable sample-worker 2>/dev/null || true
rm -f /etc/systemd/system/sample-worker.service
systemctl daemon-reload 2>/dev/null || true
echo "lab unit removed; on the host run: docker rm -f linux-lab-process-svc"
