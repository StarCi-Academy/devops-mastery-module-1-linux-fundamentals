#!/bin/bash
# 99-cleanup.sh — exit the disposable container.
# The --rm flag in run-lab.sh removes the container and all its contents automatically.
# Nothing is left on the host after 'exit'.
echo "Exiting lab container. The --rm flag removes all changes automatically."
exit 0
