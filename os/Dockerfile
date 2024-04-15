######################################################
# ImageName : Operation System Image
# Platform : amd64, arm64
# Author : Seele.Clover
# Copyright (c) 2024 by GDMU-NA, All Rights Reserved.
######################################################

# this Dockerfile is used to build the os image using apt, such as debian/ubuntu/kali-linux, etc.

ARG SYSTEM_IMAGE
ARG SYSTEM_VERSION
FROM ${SYSTEM_IMAGE}:${SYSTEM_VERSION} as system

LABEL org.opencontainers.image.name=${SYSTEM_IMAGE} \
    org.opencontainers.image.version=${SYSTEM_VERSION} \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.maintainer="Seele.Clover" \
    org.opencontainers.image.vendor="GDMU-NA" \
    org.opencontainers.image.repository="https://github.com/gdmuna/docker-images" \
    org.opencontainers.image.url="https://hub.docker.com/r/gdmuna/docker-images"

EXPOSE 22
ENV LANG=C.UTF-8 \
    TZ=Asia/Shanghai

WORKDIR /root

COPY --chown=root:root ./motd /etc/
COPY --chown=root:root ./init/* /root/init/

RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    # allow apt to work with https-based sources
    && apt-get install -y --no-install-recommends ca-certificates \
    && chmod +x /root/init/setAptSource.sh \
    # add timezone setting
    && apt-get install -y tzdata \
    && echo "${TZ}" > /etc/timezone && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && dpkg-reconfigure --frontend noninteractive tzdata \
    # add ssh service
    && apt-get install -y --no-install-recommends openssh-server \
    && sed -i "/PermitRootLogin prohibit-password/a\PermitRootLogin yes" /etc/ssh/sshd_config \
    && chmod +x /root/init/setRootPassword.sh \
    # obtain the env of the container itself from 1st process and set it as the env of ssh
    && echo '' >> /etc/profile \
    && echo 'export $(cat /proc/1/environ | tr "\\0" "\\n" | xargs)' >> /etc/profile \
    && echo '' >> /root/.bashrc \
    && echo 'source /etc/profile' >> /root/.bashrc \
    # add common tools
    && apt-get install -y --no-install-recommends vim \
    && apt-get install -y --no-install-recommends htop \
    && apt-get install -y --no-install-recommends curl wget \
    && apt-get install -y --no-install-recommends iproute2 iputils-ping traceroute \
    # clean up cache
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash", "-c", "/etc/init.d/ssh start && tail -f /dev/null"]
