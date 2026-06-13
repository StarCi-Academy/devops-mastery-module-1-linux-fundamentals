#!/bin/bash
# Flow 5 — find files and run commands with find -exec (lesson body 2.1.5.5)
set -x

# Find all .log files recursively
find . -name "*.log" -type f

# Find files modified in the last 7 days
find . -name "*.log" -mtime -7

# Find files larger than 1 MB
find . -size +1M -type f

# Run a command on each match with -exec (one call per file)
find . -name "*.log" -exec wc -l {} \;

# Use -exec ... + to pass multiple files in one call (faster)
find data/ -name "*.csv" -exec wc -l {} +

# Find executable files in /usr/bin matching grep*
find /usr/bin -maxdepth 1 -type f -perm /111 -name "grep*"
