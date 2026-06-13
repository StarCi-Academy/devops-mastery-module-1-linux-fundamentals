FROM ubuntu:22.04

# Networking-basics lab image: operator toolset + a target web app + sshd,
# all in one disposable container. ufw/iptables need --cap-add NET_ADMIN at run time.
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
        iproute2 \
        iputils-ping \
        dnsutils \
        curl \
        python3 \
        openssh-server \
        openssh-client \
        ufw \
        ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Prepare sshd: allow root login with keys, create the privilege-separation dir.
RUN mkdir -p /run/sshd \
    && sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config \
    && sed -i 's/^#\?PubkeyAuthentication.*/PubkeyAuthentication yes/' /etc/ssh/sshd_config

WORKDIR /lab
COPY scripts/ /lab/scripts/
COPY run-lab.sh /lab/run-lab.sh
RUN chmod +x /lab/run-lab.sh /lab/scripts/*.sh

# Start sshd + a python web server on :8080, then keep the container alive.
CMD ["/lab/run-lab.sh"]
