#!/bin/bash
# Flow 1 — list processes with ps (top is interactive; shown non-interactively here).
set -u

echo "### ps -ef (head)"
ps -ef | head -8

echo
echo "### ps -eo pid,ppid,stat,cmd --forest (head)"
ps -eo pid,ppid,stat,cmd --forest | head -12

echo
echo "### top -b -n1 sorted by CPU (head) — non-interactive stand-in for 'top'"
top -b -n1 -o %CPU | head -12
