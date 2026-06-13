#!/usr/bin/env bash
# Entry point (container PID 1): start sshd and a web server, then idle so the
# operator can `docker exec -it net-lab bash` and run the numbered scripts.
set -euo pipefail

# Start the OpenSSH daemon (listens on :22).
service ssh start || /usr/sbin/sshd

# Start a simple web app on :8080 in the background (the curl / ufw target).
python3 -m http.server 8080 --bind 0.0.0.0 >/var/log/weblab.log 2>&1 &

echo "net-lab ready: sshd on :22, http.server on :8080"
echo "Run: docker exec -it net-lab bash   then  bash scripts/00-ip-and-routing.sh"

# Keep PID 1 alive.
tail -f /dev/null
