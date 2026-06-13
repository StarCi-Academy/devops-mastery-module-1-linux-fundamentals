#!/bin/bash
# run-lab.sh — build and start the disposable Ubuntu container for the shell-and-filesystem lab.
# Usage: bash run-lab.sh
# After this script runs, you are dropped into an interactive shell inside the container.
# Type 'exit' to leave; the --rm flag removes the container automatically.

set -e

IMAGE_NAME="linux-lab-shell:0"
CONTAINER_NAME="linux-lab-shell"

echo "==> Building lab image from Dockerfile..."
docker build -t "${IMAGE_NAME}" .

echo "==> Starting disposable container. Type 'exit' when done."
docker run --rm -it --name "${CONTAINER_NAME}" "${IMAGE_NAME}" /bin/bash
