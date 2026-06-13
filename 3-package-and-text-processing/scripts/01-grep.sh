#!/bin/bash
# Flow 2 — find error lines in a log with grep (lesson body 2.1.5.2)
set -x

# Count total lines in the log
wc -l sample.log

# Find all HTTP 500 lines (case-sensitive)
grep '" 500 ' sample.log | head -5

# Case-insensitive search (-i)
grep -i 'error' data/app.log | wc -l

# Print with line numbers (-n)
grep -n '" 500 ' sample.log | head -3

# Extended regex (-E): find 4xx or 5xx status codes
grep -E '" [45][0-9]{2} ' sample.log | wc -l

# Recursive search inside the data directory (-r)
grep -r 'WARN' data/ | head -3

# Find internal IPs 10.x.x.x with status 500
grep -E '10\.[0-9]+\.[0-9]+\.[0-9]+.*" 500 ' sample.log | wc -l
