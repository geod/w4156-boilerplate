#!/bin/bash

CONTAINERID=`docker ps | grep w4156 | cut -d" " -f1`

if [ -z ${CONTAINERID} ];
then
 echo "Container not found"
else
 docker exec -it $CONTAINERID bash
fi

