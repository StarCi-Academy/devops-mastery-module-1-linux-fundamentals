# Disposable Ubuntu lab for package management + text processing.
# Everything (grep/sed/awk/find/tar/gzip/apt/dpkg) ships with ubuntu:22.04.
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# python3 is used ONLY to generate the seed log/CSV at build time — not part of
# the skill being practiced (grep/sed/awk/find handle the extraction).
RUN apt-get update \
 && apt-get install -y --no-install-recommends python3 ca-certificates \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /root/lab

# Seed an Apache-Combined-style access log (~5000 lines) and sample CSV data.
COPY seed.py /tmp/seed.py
RUN python3 /tmp/seed.py && rm /tmp/seed.py

# Lab scripts (one per flow, copy-pasted from lesson body section 2.1.5).
COPY scripts/ /root/lab/scripts/
COPY run-lab.sh /root/lab/run-lab.sh
RUN chmod +x /root/lab/run-lab.sh /root/lab/scripts/*.sh

CMD ["/bin/bash"]
