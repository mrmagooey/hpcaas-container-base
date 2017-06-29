#!/bin/bash

apt-get install -y python-software-properties

add-apt-repository ppa:gluster/glusterfs-3.11

apt-get update

apt-get install -y glusterfs-client

