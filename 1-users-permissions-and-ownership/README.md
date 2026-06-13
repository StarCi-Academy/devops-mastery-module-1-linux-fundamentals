# Lab — Users, Permissions & Ownership (MODE-B)

Disposable Ubuntu 22.04 container seeded with sample users, groups and
intentionally broken file permissions. You practice by typing the lesson's
commands **directly inside the container shell** (MODE-B) — there is no
application to run, only Linux itself.

## Quick start

```bash
# Build the image
docker build -t linux-lab-permissions:0 .

# Run a disposable interactive shell (everything is wiped on exit)
docker run --rm -it --name linux-lab-permissions linux-lab-permissions:0 /bin/bash
```

Or use the helper:

```bash
./run-lab.sh build
./run-lab.sh run
```

## What is seeded

| Item | Detail |
| --- | --- |
| Users | `alice` (1001), `bob` (1002), `carol` (1003) |
| Groups | `dev` (1100) — alice+bob; `ops` (1101) |
| `/lab/scripts/deploy.sh` | mode `644` (missing execute), group `dev` |
| `/lab/configs/app.conf` | mode `666` (world-writable) |
| `/lab/configs/secret.conf` | mode `644` |
| `/lab/data/*.csv,*.json` | owned by `root:root` (re-owned in Flow 5) |

## Files

- `Dockerfile` — `FROM ubuntu:22.04`, installs `sudo`, runs the seed scripts at build.
- `scripts/00-seed-users.sh` — creates the users and groups (fixed uid/gid).
- `scripts/01-seed-files.sh` — creates `/lab` with the broken-permission samples.
- `scripts/99-cleanup.sh` — removes the lab image from the host.
- `run-lab.sh` — `build` / `run` / `clean` helper.

## Cleanup

The container is started with `--rm`, so simply `exit` the shell to discard it.
To also remove the image:

```bash
./run-lab.sh clean   # or: docker image rm linux-lab-permissions:0
```
