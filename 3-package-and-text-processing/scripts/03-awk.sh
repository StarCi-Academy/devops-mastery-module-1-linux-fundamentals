#!/bin/bash
# Flow 4 — extract columns with awk (lesson body 2.1.5.4)
set -x

# Print the first field ($1 = IP address in Apache log format)
awk '{print $1}' sample.log | head -5

# Print the last field ($NF = response size)
awk '{print $NF}' sample.log | head -5

# Sum total response bytes
awk '{sum += $NF} END {print "Total bytes:", sum}' sample.log

# Filter 500-status lines and print IP + status (fields 1 and 9)
awk '$9 == "500" {print $1, $9}' sample.log | head -5

# Count requests per status code
awk '{print $9}' sample.log | sort | uniq -c | sort -rn

# Extract columns from a comma-separated CSV
awk -F',' '{print $1, $3}' data/metrics.csv | head -5
