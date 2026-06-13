# Users, Permissions & Ownership — disposable lab (MODE-B)
# Build: docker build -t linux-lab-permissions:0 .
# Run:   docker run --rm -it --name linux-lab-permissions linux-lab-permissions:0 /bin/bash
FROM ubuntu:22.04

# sudo is needed for the sudo/su flow; passwd utilities ship in base image.
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends sudo \
    && rm -rf /var/lib/apt/lists/*

# Seed scripts are copied in and run during build so the container starts
# already populated with the (intentionally broken) sample state.
COPY scripts/ /opt/lab-scripts/
RUN chmod +x /opt/lab-scripts/*.sh \
    && /opt/lab-scripts/00-seed-users.sh \
    && /opt/lab-scripts/01-seed-files.sh

WORKDIR /lab
CMD ["/bin/bash"]
