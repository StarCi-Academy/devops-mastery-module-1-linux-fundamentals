#!/bin/bash
# Flow 6 — env vars, PATH, tar/gzip + 2 real failure modes (lesson body 2.1.5.6)
set -x

# Inspect the current PATH
echo $PATH

# Create a script in a custom tools directory
mkdir -p /opt/mytools
cat > /opt/mytools/hello.sh << 'EOF'
#!/bin/bash
echo "Hello from mytools!"
EOF
chmod +x /opt/mytools/hello.sh

# Add the directory to PATH for the current session
export PATH="$PATH:/opt/mytools"
echo $PATH
hello.sh

# Persist the change to .bashrc (takes effect in new shells)
echo 'export PATH="$PATH:/opt/mytools"' >> ~/.bashrc

# Inspect exported environment variables
export | grep PATH

# Compress the data/ directory into a .tar.gz archive
tar -czf /tmp/data-backup.tar.gz data/

# List archive contents without extracting (-t)
tar -tzf /tmp/data-backup.tar.gz

# Extract to a different directory
mkdir -p /tmp/restore
tar -xzf /tmp/data-backup.tar.gz -C /tmp/restore

# Compare sizes before and after compression
du -sh data/ /tmp/data-backup.tar.gz

set +x
echo "===== FAILURE MODE 1a: grep no-match in a PIPELINE under bare set -e (NOT caught) ====="
( set -e
  grep "this-pattern-never-exists" sample.log | wc -l   # prints 0; grep exits 1 but it is NOT the last cmd
  echo "STILL REACHED — bare set -e ignores grep's failure inside a pipeline (status = wc -l = 0)"
)
echo "pipeline subshell exit code: $?"

echo "===== FAILURE MODE 1b: same pipeline WITH set -o pipefail (now caught) ====="
( set -e
  set -o pipefail
  grep "this-pattern-never-exists" sample.log | wc -l   # pipefail surfaces grep's exit 1
  echo "this line is NOT reached under pipefail"
)
echo "pipefail subshell exit code: $?"

echo "===== FAILURE MODE 2: tar -xzf -C into a non-existent directory ====="
rm -rf /tmp/nope
tar -xzf /tmp/data-backup.tar.gz -C /tmp/nope/restore
echo "tar exit code: $?"
