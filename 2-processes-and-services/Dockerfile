# Disposable Ubuntu 22.04 lab with full systemd (run with --privileged + /sbin/init).
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV container=docker

# systemd + the tools the flows exercise (ps/top from procps, python3 for the worker).
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        systemd systemd-sysv \
        procps psmisc \
        python3 \
        ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Strip the systemd units that are useless / harmful inside a container.
RUN find /etc/systemd/system /lib/systemd/system \
        -path '*.wants/*' \
        \( -name '*udev*' -o -name '*getty*' -o -name '*resolved*' \
           -o -name '*networkd*' -o -name '*timesyncd*' \) \
        -exec rm -f {} + || true

COPY scripts/ /scripts/
RUN chmod +x /scripts/*.sh /scripts/sample-worker.py 2>/dev/null || true

# PID 1 = systemd. Enter with: docker exec -it <name> /bin/bash
CMD ["/sbin/init"]
