FROM phusion/baseimage:0.9.22

# init system
CMD ["/sbin/my_init"]

# Upgrade system
RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"

## Setup HPCaaS ##
RUN mkdir -p /hpcaas/
RUN mkdir -p /hpcaas/code # user code directory
RUN mkdir -p /hpcaas/results # results directory
RUN mkdir -p /hpcaas/updates # file communication with the daemon
RUN mkdir -p /hpcaas/services # services code

RUN mkdir -p /etc/my_init.d # runtime scripts

## HPCaaS Container Daemon ##
COPY container-daemon.sh /etc/service/hpcaas-container-daemon/run
COPY hpcaas-container-daemon/hpcaas-container-daemon /usr/local/bin/hpcaas-container-daemon

# Enable SSH
RUN rm -f /etc/service/sshd/down

# Distributed file system
# off by default
ENV DISTRIBUTED_FILE_SYSTEM_ENABLED=FALSE
# the install script
COPY services/glusterfs-install.sh /hpcaas/services/glusterfs-install.sh
# the runtime script
COPY services/glusterfs-run /etc/my_init.d/glusterfs-run 

## Scientific code ##
ENV CODE_BINARY_NAME=hpc_code

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

