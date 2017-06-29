# HPCaaS-Container-Base

This is the base for all HPCaaS containers. 

It is not intended to be used directly, that is what the hpcaas-container-template is for.

## Build

Run `make` to build the container image. This should download the container daemon subrepo, build the daemon, then build the base container with the daemon inside of it.

