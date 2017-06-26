#!/bin/bash

apt-get install -y python-software-properties

add-apt-repository ppa:gluster/glusterfs-3.5

apt-get update

apt-get install -y glusterfs-server glusterfs-client

