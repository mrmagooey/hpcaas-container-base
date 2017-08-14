#!/bin/bash

build_directory='/base_build'

## Setup HPCaaS ##
mkdir -p /hpcaas/
mkdir -p /hpcaas/code # user code directory
mkdir -p /hpcaas/results # final results directory
mkdir -p /hpcaas/services # services code
mkdir -p /hpcaas/daemon # daemon directory
mkdir -p /hpcaas/runtime # runtime information for the users code

## HPCaaS Container Daemon ##
mkdir -p /etc/service/hpcaas-container-daemon/
cp $build_directory/runtime_scripts/container-daemon.runit /etc/service/hpcaas-container-daemon/run
cp $build_directory/hpcaas-container-daemon/hpcaas-container-daemon /usr/local/bin/hpcaas-container-daemon
