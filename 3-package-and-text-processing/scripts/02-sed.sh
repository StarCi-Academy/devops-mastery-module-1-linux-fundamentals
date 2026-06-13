#!/bin/bash
# Flow 3 — bulk string replacement with sed (lesson body 2.1.5.3)
set -x

# Replace the first occurrence per line: HTTP/1.0 -> HTTP/1.1
sed 's/HTTP\/1\.0/HTTP\/1.1/' sample.log | grep 'HTTP/1.1' | head -3

# Replace every occurrence on each line (g flag)
sed 's/ERROR/WARN/g' data/app.log | grep WARN | head -3

# Print only matching lines (-n + p): filter like grep but can transform first
sed -n '/" 500 /p' sample.log | head -5

# Delete blank lines
sed '/^$/d' sample.log | wc -l

# Edit a copy in-place (use a temp file — never modify the original in a lab)
cp sample.log /tmp/sample-edit.log
sed -i 's/10\.0\./192.168./g' /tmp/sample-edit.log
grep '192.168.' /tmp/sample-edit.log | head -3
