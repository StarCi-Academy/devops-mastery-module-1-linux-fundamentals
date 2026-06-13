#!/usr/bin/env bash
# Flow 4 — generate an Ed25519 keypair, install the public key, SSH over loopback.
set -euo pipefail

# Generate a keypair (no passphrase for lab convenience). Overwrite if present.
rm -f ~/.ssh/lab_id ~/.ssh/lab_id.pub
ssh-keygen -t ed25519 -C "lab-key" -f ~/.ssh/lab_id -N ""

# Install the public key into this host's own authorized_keys.
mkdir -p ~/.ssh && chmod 700 ~/.ssh
cat ~/.ssh/lab_id.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys

# SSH into the same host over loopback and run a single command (no password prompt).
echo "== ssh root@127.0.0.1 (key auth) =="
ssh -i ~/.ssh/lab_id -o StrictHostKeyChecking=no root@127.0.0.1 \
    'echo "logged in as $(whoami) on $(hostname) via key auth"'
