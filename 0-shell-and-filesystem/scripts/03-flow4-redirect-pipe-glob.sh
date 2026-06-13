#!/bin/bash
# Flow 4 — Redirection, pipes, and globbing
# Backing script: copy-paste these commands into the interactive container shell.

# > redirect stdout to a file (overwrites if the file exists)
cd /lab/tmp
echo "Build started at $(date)" > build.log
cat build.log

# >> append to the end of a file (no overwrite)
echo "Step 1: done" >> build.log
echo "Step 2: done" >> build.log
cat build.log

# | pipe: stdout of the left command -> stdin of the right command
# Count the number of ERROR lines in the log
cat /lab/logs/app.log | grep ERROR | wc -l

# Sort and deduplicate
cat /lab/logs/app.log | grep -o '\[.*\]' | sort | uniq -c | sort -rn

# Globbing: * matches any string, ? one char, [ ] a char set
cd /lab/logs
ls *.log                    # all .log files
ls app.lo?                  # app.log, but not app.logs
ls *[0-9].log               # files ending with a digit then .log

# Use a glob with cp to copy multiple files at once
mkdir -p /lab/tmp/log-archive
cp /lab/logs/*.log /lab/tmp/log-archive/
ls /lab/tmp/log-archive/ | wc -l
