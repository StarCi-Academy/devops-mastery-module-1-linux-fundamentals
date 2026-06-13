#!/usr/bin/env bash
# Flow 3 — name resolution: /etc/hosts, dig, nslookup.
set -euo pipefail

echo "== cat /etc/hosts =="
cat /etc/hosts

echo "== dig localhost =="
dig localhost +noall +answer || dig localhost

echo "== nslookup localhost =="
nslookup localhost || true
