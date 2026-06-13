# Lab — Package Management & Text Processing

Disposable Ubuntu 22.04 container for practising `apt`/`dpkg` and the text-processing
toolkit (`grep`, `sed`, `awk`, `find`, `tar`/`gzip`). Nothing is installed on the host.

## Layout

```
Dockerfile          # FROM ubuntu:22.04, seeds sample.log + data/ at build time
seed.py             # build-time generator for the seed data (not a lab skill)
run-lab.sh          # runs all 6 flows in order
scripts/
  00-apt-dpkg.sh    # Flow 1 — install/remove a package with apt + dpkg states
  01-grep.sh        # Flow 2 — filter error lines with grep -E
  02-sed.sh         # Flow 3 — bulk substitution with sed
  03-awk.sh         # Flow 4 — field extraction + frequency table with awk
  04-find.sh        # Flow 5 — find files and run commands with -exec
  05-path-tar.sh    # Flow 6 — PATH/env, tar/gzip, + 2 real failure modes
```

Seed data (built into the image):

- `sample.log` — 5000 lines of Apache Combined Log Format (field 9 = status code).
- `data/metrics.csv`, `data/access.csv` — small CSVs for `awk -F','`.
- `data/app.log` — a second `.log` so `find` returns more than one match.

## Run

```bash
# Step 1: build the image from this folder
docker build -t linux-lab-pkg:0 .

# Step 2: run a disposable interactive container
docker run --rm -it --name linux-lab-pkg linux-lab-pkg:0 /bin/bash

# Step 3 (inside the container): run a single flow or all of them
bash scripts/01-grep.sh
./run-lab.sh
```

## Cleanup

`--rm` deletes the container on exit. Remove the image with:

```bash
docker rmi linux-lab-pkg:0
```
