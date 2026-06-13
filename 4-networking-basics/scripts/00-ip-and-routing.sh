#!/usr/bin/env bash
# Flow 1 — inspect IP addresses and the routing table.
set -euo pipefail

echo "== ip addr show =="
ip addr show

echo "== ip route show =="
ip route show

echo "== hostname -I =="
hostname -I
