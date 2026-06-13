# 4 — Networking Basics & SSH (MODE-B lab)

A single disposable Ubuntu 22.04 container that plays both the **operator
workstation** and the **target** (a Python web app on `:8080` + `sshd` on `:22`).
You SSH/scp into the same container over loopback `127.0.0.1`, so the scripts are
copy-paste friendly and the client→server mechanism is still real.

## Run

```bash
# Build the image
docker build -t net-lab .

# Run with NET_ADMIN so ufw/iptables work inside the container
docker run -d --name net-lab --cap-add NET_ADMIN net-lab

# Open a shell inside the container
docker exec -it net-lab bash
```

## Flows (run inside the container)

| Script | Flow | What it shows |
|---|---|---|
| `scripts/00-ip-and-routing.sh` | 1 | `ip addr`, `ip route`, `hostname -I` |
| `scripts/01-listening-ports.sh` | 2 | `ss -tlnp` + `curl` the web app |
| `scripts/02-dns-and-hosts.sh` | 3 | `/etc/hosts`, `dig`, `nslookup` |
| `scripts/03-ssh-keygen-and-login.sh` | 4 | Ed25519 keypair + key-based SSH over loopback |
| `scripts/04-scp-copy.sh` | 5 | `scp` a file over loopback |
| `scripts/05-ufw-firewall.sh` | 6 | `ufw` default-deny; `deny 8080` → `curl` timeout |
| `scripts/99-cleanup.sh` | — | reset lab state inside the container |

Example:

```bash
bash scripts/00-ip-and-routing.sh
bash scripts/01-listening-ports.sh
# ... through 05
```

## Cleanup

```bash
# From the host
docker rm -f net-lab
```

## Notes

- `--cap-add NET_ADMIN` is **required**; without it `ufw`/`iptables` fail with a
  permission error and Flow 6's failure mode cannot be reproduced.
- Docker Desktop on Windows/macOS runs a LinuxKit VM; `ufw` enforcement depends on
  the VM kernel supporting iptables — on a native Linux host it always works.
