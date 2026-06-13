#!/usr/bin/env bash
# Flow 6 — ufw default-deny, then a deterministic failure mode (stop service ->
# connection refused). Requires --cap-add NET_ADMIN for the ufw rules.
set -uo pipefail

echo "== allow SSH first, then enable default-deny =="
ufw allow 22/tcp
ufw --force enable

echo "== allow 8080 and show the rule table =="
ufw allow 8080/tcp
ufw status numbered

echo "== curl works while the service is up =="
curl --connect-timeout 3 -s -o /dev/null -w 'HTTP %{http_code}\n' http://127.0.0.1:8080/

echo "== stop the web server and observe connection refused (failure mode) =="
# Stopping the listener is the deterministic, kernel-independent failure: the OS
# returns RST immediately -> curl: (7) Connection refused (NOT a timeout).
pkill -f http.server
sleep 1
curl --connect-timeout 3 http://127.0.0.1:8080/ || echo "curl: (7) connection refused as expected (no process listening)"
