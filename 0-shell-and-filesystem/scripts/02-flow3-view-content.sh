#!/bin/bash
# Flow 3 — View file content
# Backing script: copy-paste these commands into the interactive container shell.
# Note: 'less' requires an interactive terminal; skipped in non-interactive E2E run.

# cat: prints the entire file to stdout (fine for small files)
cd /lab/logs
cat app.log

# head: print only the first N lines (default 10)
head -5 app.log

# tail: print the last N lines — very useful to see the newest log entries
tail -20 app.log
