# 0-shell-and-filesystem

**Module:** DevOps Mastery — Linux Fundamentals  
**Lesson:** Shell & Filesystem

## Overview

A disposable Ubuntu 22.04 container lab. Learners drop into an interactive bash shell and run commands copy-pasted from the lesson body. No installation needed on the host beyond Docker.

## Prerequisites

- Docker Desktop (macOS/Windows) or Docker Engine (Linux) running
- macOS / Linux / Windows + WSL2 (POSIX shell required; PowerShell-only is not supported)

## Start the lab

```bash
bash run-lab.sh
```

This builds the image and drops you into `/lab` inside the container. Type `exit` to quit. The `--rm` flag removes the container and all changes automatically.

## Manual build/run

```bash
docker build -t linux-lab-shell:0 .
docker run --rm -it --name linux-lab-shell linux-lab-shell:0 /bin/bash
```

## Lab structure

```
0-shell-and-filesystem/
├── Dockerfile          # FROM ubuntu:22.04, seeds /lab/
├── run-lab.sh          # convenience wrapper: build + run
├── lab/                # seeded into /lab/ at build time
│   ├── configs/        # sample config files (app.conf, nginx.conf)
│   ├── logs/           # sample log files (app.log, error.log, nginx.log, access1.log)
│   ├── scripts/        # sample shell scripts (not executable in lab)
│   ├── users/          # sample user data files
│   └── tmp/            # empty scratch space
└── scripts/            # backing answer-key scripts (not called from the lesson body)
    ├── 00-flow1-navigation.sh
    ├── 01-flow2-file-ops.sh
    ├── 02-flow3-view-content.sh
    ├── 03-flow4-redirect-pipe-glob.sh
    ├── 04-flow5-edge-cases.sh
    └── 99-cleanup.sh
```

## Flows covered

| Flow | Topic |
|------|-------|
| 1 | Navigate directory tree (`pwd`, `cd`, `ls`) |
| 2 | File and directory operations (`touch`, `mkdir`, `cp`, `mv`, `rm`) |
| 3 | View file content (`cat`, `head`, `tail`) |
| 4 | Redirection, pipes, globbing (`>`, `>>`, `\|`, `grep`, `wc`, `*`) |
| 5 | Edge cases and failure modes (glob no-match, empty-var `rm -rf`, spaces in filenames) |
