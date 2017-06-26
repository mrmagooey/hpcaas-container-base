#!/bin/bash

service glusterd start

for container_name in CLUSTER_CONTAINER_NAMES
do
    gluster peer probe $container_name
done

mkdir -p /hpcaas/shared/

if [$WORLD_RANK=0]
   then
       gluster volume create gv0 replica
       CONTAINER_DATA_NAMES=
       gluster volume start gv0 replica $WORLD_SIZE 
fi

