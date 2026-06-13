#!/bin/bash
# Flow 4 — read exit code $? after each command.

# Exit code 0 = success
ls /tmp >/dev/null
echo "Exit code of ls: $?"

# Non-zero exit code = error
ls /nonexistent 2>/dev/null
echo "Exit code of failed ls: $?"

# Script sets its own exit code
bash -c 'exit 42'
echo "Exit code 42: $?"

# Use $? for decision-making in a script
if grep -q "root" /etc/passwd; then
    echo "Found root user (exit 0)"
fi
echo "Exit code of grep: $?"
