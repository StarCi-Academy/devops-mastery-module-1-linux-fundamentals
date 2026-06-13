#!/usr/bin/env bash
# Flow 2 — inspect listening ports and curl the local web app.
set -euo pipefail

echo "== ss -tlnp =="
ss -tlnp

echo "== curl http://127.0.0.1:8080/ =="
curl -s http://127.0.0.1:8080/ | head -3
