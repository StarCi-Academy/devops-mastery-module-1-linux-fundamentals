#!/bin/bash
# Flow 5 — Edge cases and failure modes
# Backing script: copy-paste these commands into the interactive container shell.
# These demonstrate real production failure patterns.

cd /lab/tmp

# (1) A non-matching glob -> bash passes the LITERAL pattern, not an empty list
ls *.nomatch
# -> ls: cannot access '*.nomatch': No such file or directory
# Compare: with nullglob the pattern expands to nothing instead of the literal
shopt -s nullglob
echo start; for f in *.nomatch; do echo "got $f"; done; echo end
shopt -u nullglob

# (2) Empty variable + rm -rf = disaster. We do NOT run rm; only show the expansion
EMPTY=""
echo "rm -rf $EMPTY/tmp-data  -> expands to:  rm -rf /tmp-data"
# set -u makes bash refuse an unset variable instead of expanding to ""
( set -u; echo "guarded: ${UNSET_DIR:?must be set}" ) || echo "blocked by set -u"

# (3) A space in a filename is split into multiple arguments
touch "my report.txt"
cp my report.txt /lab/tmp/log-archive/ 2>&1 || true
# -> cp: cannot stat 'my': No such file or directory  (parsed as 3 args)
cp "my report.txt" /lab/tmp/log-archive/    # quoting fixes it
ls /lab/tmp/log-archive/
