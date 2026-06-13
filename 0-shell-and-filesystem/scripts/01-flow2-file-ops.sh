#!/bin/bash
# Flow 2 — File and directory operations
# Backing script: copy-paste these commands into the interactive container shell.

# Create an empty file with touch (or update the timestamp if it already exists)
cd /lab/tmp
touch report.txt
ls -l report.txt

# Create a new directory
mkdir backups
mkdir -p archive/2024/jan      # -p creates the full intermediate path

# Copy a file
cp report.txt backups/report-backup.txt
ls backups/

# Move / rename a file
mv report.txt report-final.txt
ls -l

# Delete a file
rm backups/report-backup.txt

# Delete an empty directory
rmdir backups

# Delete a directory with contents (use with caution!)
rm -rf archive
