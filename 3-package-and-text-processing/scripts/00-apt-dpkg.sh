#!/bin/bash
# Flow 1 — install and remove a package with apt (lesson body 2.1.5.1)
set -x

# Update package metadata from repositories (nothing is installed yet)
apt update

# Inspect the package before installing
apt show jq

# Install jq
apt install -y jq

# Check version and binary location
jq --version
which jq
dpkg -L jq | grep bin

# Search for packages related to ripgrep
apt search ripgrep

# List installed packages filtered by name
dpkg -l | grep -E "^ii.*jq"

# Remove the package (keep config files)
apt remove -y jq

# Remove the package and purge config files
apt purge -y jq
dpkg -l | grep -E "^(rc|ii).*jq" || echo "jq fully purged (no rc/ii entry)"
