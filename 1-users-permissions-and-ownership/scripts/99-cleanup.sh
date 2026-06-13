#!/usr/bin/env bash
# Remove the lab image from the host. The container itself is disposable
# (started with --rm), so exiting the shell already wipes the container.
set -euo pipefail
IMAGE="${1:-linux-lab-permissions:0}"
echo "[99-cleanup] removing image ${IMAGE} (container is --rm, already gone on exit)"
docker image rm "${IMAGE}" 2>/dev/null || echo "[99-cleanup] image ${IMAGE} not present — nothing to do"
