#!/usr/bin/env bash
# Reset lab state inside the container (the disposable container itself is removed
# from the host with: docker rm -f net-lab).
set -uo pipefail

ufw --force reset || true
rm -f ~/.ssh/lab_id ~/.ssh/lab_id.pub ~/.ssh/authorized_keys
rm -f /tmp/test-file.txt /root/test-file.txt
echo "lab state reset"
