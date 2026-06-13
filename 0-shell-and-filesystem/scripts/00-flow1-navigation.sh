#!/bin/bash
# Flow 1 — Navigate the directory tree
# Backing script: copy-paste these commands into the interactive container shell.
# Do NOT run this script as a whole; each command produces observable output.

# Print working directory (show current directory)
pwd

# List with long format and hidden files
ls -la

# Move into a subdirectory
cd logs
pwd

# Go back to the parent directory — use absolute path (prefer over cd ..)
cd /lab
pwd

# Return to the current user's home directory using ~
cd ~
pwd

# Use an absolute path to reach /lab/configs
cd /lab/configs
ls -l
