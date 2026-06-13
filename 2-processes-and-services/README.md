# Lab: Processes and Services (MODE-B disposable container)

A disposable Ubuntu 22.04 container running **full systemd as PID 1** so you can
practise process control (`ps`/`top`/`kill`/`pkill`), job control (`jobs`/`fg`/`bg`),
exit codes (`$?`), and service management (`systemctl`/`journalctl`) without
installing anything on your host.

## Prerequisites

- Docker Desktop (macOS/Windows) or Docker Engine (Linux). systemd inside a
  container needs `--privileged`.
- Windows: use WSL2 Ubuntu 22.04+ (a POSIX shell).

## Run

```bash
# Build
docker build -t linux-lab-process-svc:0 .

# Run with systemd as PID 1 (requires --privileged)
docker run --rm -d --privileged --name linux-lab-process-svc linux-lab-process-svc:0

# Wait for systemd to boot, then enter the shell
sleep 3
docker exec -it linux-lab-process-svc /bin/bash
```

## Flows (run inside the container)

| Script | Flow |
| --- | --- |
| `scripts/00-process-list.sh` | List processes with `ps` / `top` |
| `scripts/01-background-jobs.sh` | Background jobs: `jobs` / `fg` / `bg` / suspend |
| `scripts/02-signal-sigterm-sigkill.sh` | SIGTERM then SIGKILL on a stubborn process |
| `scripts/03-exit-codes.sh` | Read exit code `$?` |
| `scripts/04-systemctl-journalctl.sh` | Manage `sample-worker.service` + read logs |
| `scripts/99-cleanup.sh` | Remove the lab unit inside the container |

Or run them all: `docker exec -it linux-lab-process-svc /scripts/run-lab.sh`

> The flow body copies these commands verbatim — in MODE-B you can paste the
> commands directly into the shell instead of calling the scripts.

## Cleanup

```bash
docker rm -f linux-lab-process-svc
docker rmi linux-lab-process-svc:0
```
