#!/bin/bash
# Runs all 6 lab flows in sequence inside the container.
# Usage (inside the container):  ./run-lab.sh
set -u
cd "$(dirname "$0")"

for s in scripts/00-apt-dpkg.sh \
         scripts/01-grep.sh \
         scripts/02-sed.sh \
         scripts/03-awk.sh \
         scripts/04-find.sh \
         scripts/05-path-tar.sh; do
  echo ""
  echo "########################################################"
  echo "# RUNNING $s"
  echo "########################################################"
  bash "$s"
done

echo ""
echo "All 6 flows finished."
