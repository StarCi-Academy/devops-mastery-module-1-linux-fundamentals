#!/bin/bash
# Flow 5 — manage a service with systemctl and read logs with journalctl.
set -u

# Copy the unit file into the systemd system directory
cp /scripts/sample-worker.service /etc/systemd/system/

# Reload systemd to pick up the new unit
systemctl daemon-reload

# Check initial status (inactive) — status returns non-zero when inactive, so guard it
echo "### initial status"
systemctl status sample-worker --no-pager || true

# Start the service
systemctl start sample-worker
sleep 3

# Check status (should be active running)
echo "### status after start"
systemctl status sample-worker --no-pager || true

# Read service logs
echo "### journalctl -u sample-worker -n 10"
journalctl -u sample-worker --no-pager -n 10

# Restart the service (PID should change)
echo "### restart"
PID_BEFORE=$(systemctl show -p MainPID --value sample-worker)
systemctl restart sample-worker
sleep 2
PID_AFTER=$(systemctl show -p MainPID --value sample-worker)
echo "MainPID before=$PID_BEFORE after=$PID_AFTER"

# Enable / disable (symlink for boot)
echo "### enable"
systemctl enable sample-worker
echo "### disable"
systemctl disable sample-worker

# Stop the service
systemctl stop sample-worker
echo "### status after stop"
systemctl status sample-worker --no-pager || true
