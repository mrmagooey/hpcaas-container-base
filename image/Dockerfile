FROM phusion/baseimage:0.9.22

# init system
CMD ["/sbin/my_init"]

# Upgrade system
RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"

## Setup HPCaaS ##
RUN mkdir -p /hpcaas/
RUN mkdir -p /hpcaas/code # user code directory
RUN mkdir -p /hpcaas/data # results directory
RUN mkdir -p /hpcaas/updates # file communication with the daemon
RUN mkdir -p /hpcaas/services # services code

## HPCaaS Container Daemon ##
COPY container-daemon.sh /etc/service/hpcaas-container-daemon/run
COPY hpcaas-container-daemon/hpcaas-container-daemon /usr/local/bin/hpcaas-container-daemon

# Enable SSH
RUN rm -f /etc/service/sshd/down

# GlusterFS
COPY services/glusterfs.sh /hpcaas/services/glusterfs.sh

## Scientific code ##
ENV CODE_BINARY_NAME=hpc_code

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

