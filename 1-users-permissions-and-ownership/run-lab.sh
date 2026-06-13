#!/usr/bin/env bash
# Convenience wrapper for the disposable permissions lab.
#   ./run-lab.sh build   -> build the image
#   ./run-lab.sh run     -> run a disposable interactive container (default)
#   ./run-lab.sh clean   -> remove the image (delegates to scripts/99-cleanup.sh)
set -euo pipefail

IMAGE="linux-lab-permissions:0"
NAME="linux-lab-permissions"
cmd="${1:-run}"

case "$cmd" in
  build)
    docker build -t "$IMAGE" .
    ;;
  run)
    docker run --rm -it --name "$NAME" "$IMAGE" /bin/bash
    ;;
  clean)
    bash scripts/99-cleanup.sh "$IMAGE"
    ;;
  *)
    echo "usage: $0 {build|run|clean}" >&2
    exit 2
    ;;
esac
