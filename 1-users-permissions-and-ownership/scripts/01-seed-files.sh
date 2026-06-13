#!/usr/bin/env bash
# Seed /lab with files and scripts that have INTENTIONALLY broken permissions,
# matching the "before" state used by the verification flows in the lesson body.
set -euo pipefail

mkdir -p /lab/scripts /lab/configs /lab/data /lab/data/alice-workspace

# --- Flow 3: a deploy script missing the execute bit (644) ---
cat > /lab/scripts/deploy.sh <<'EOF'
#!/usr/bin/env bash
echo "[deploy.sh] running as $(id -un) ($(id)) at $(date -u +%FT%TZ)"
EOF
chown root:dev /lab/scripts/deploy.sh
chmod 644 /lab/scripts/deploy.sh   # broken on purpose: no execute bit

# --- Flow 4: config files that are world-writable / need tightening ---
echo "listen_port=8080" > /lab/configs/app.conf
chown root:dev /lab/configs/app.conf
chmod 666 /lab/configs/app.conf    # insecure on purpose: everyone can write

echo "API_KEY=lab-placeholder" > /lab/configs/secret.conf
chown root:dev /lab/configs/secret.conf
chmod 644 /lab/configs/secret.conf

# --- Flow 5: data files owned by root, to be re-owned to alice/bob ---
echo "ts,cpu,mem" > /lab/data/report.csv
chown root:root /lab/data/report.csv
chmod 644 /lab/data/report.csv

echo '{"latency_ms":12}' > /lab/data/metrics.json
chown root:root /lab/data/metrics.json
chmod 644 /lab/data/metrics.json

echo "scratch" > /lab/data/alice-workspace/notes.txt
chown -R root:root /lab/data/alice-workspace
chmod 755 /lab/data/alice-workspace

echo "[01-seed-files] seeded /lab with broken-permission samples"
ls -lR /lab || true
