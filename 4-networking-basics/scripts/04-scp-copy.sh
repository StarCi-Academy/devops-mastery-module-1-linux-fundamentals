#!/usr/bin/env bash
# Flow 5 — copy a file over loopback with scp using the lab key.
set -euo pipefail

echo "hello over ssh" > /tmp/test-file.txt

echo "== scp /tmp/test-file.txt -> root@127.0.0.1:/root/ =="
scp -i ~/.ssh/lab_id -o StrictHostKeyChecking=no /tmp/test-file.txt root@127.0.0.1:/root/

echo "== cat /root/test-file.txt =="
cat /root/test-file.txt
