#!/usr/bin/env bash
# Seed the lab users and groups. Fixed uid/gid so the body's expected output is
# reproducible: alice=1001, bob=1002, carol=1003; group dev=1100, ops=1101.
set -euo pipefail

# Groups first (fixed gid so `id` output matches the lesson body).
groupadd -g 1100 dev
groupadd -g 1101 ops

# Three users with deterministic uids and a real login shell.
useradd -m -u 1001 -s /bin/bash -c "Alice Dev,,," alice
useradd -m -u 1002 -s /bin/bash -c "Bob Dev,,,"   bob
useradd -m -u 1003 -s /bin/bash -c "Carol Ops,,," carol

# alice + bob are in the dev group (carol is intentionally NOT).
usermod -aG dev alice
usermod -aG dev bob

# Set simple lab passwords so `su -` works non-interactively if needed.
echo "alice:devops123" | chpasswd
echo "bob:devops123"   | chpasswd
echo "carol:devops123" | chpasswd

# Lab-only: let the sudo group run sudo without a password so the sudo flow
# is reproducible non-interactively (a real host would prompt for a password).
echo '%sudo ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/lab-nopasswd
chmod 0440 /etc/sudoers.d/lab-nopasswd

echo "[00-seed-users] created alice(1001) bob(1002) carol(1003); groups dev(1100) ops(1101)"
