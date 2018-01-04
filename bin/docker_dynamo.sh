#!/bin/bash

name=dynamo
pwd=devpassword
echo "name:"$name

function stop() {
    echo "Checking if container for $name is running ....."
    CONTAINERID=`docker ps | grep dynamo | cut -d" " -f1`
    if [ -z ${CONTAINERID} ];
    then
        echo "   Container was not running"
    else
        echo "   Running Container for $name found. Stopping $CONTAINERID"
        docker stop $CONTAINERID
    fi
}

case "$1" in
        pull)
	        docker pull cnadiminti/dynamodb-local
	        ;;

        start)
            stop
            echo "Removing previous container for $name"
            docker rm $(docker ps -aq --filter name=$name)
            echo "Starting Container ...."
	        docker run -v $pwd:/dynamodb_local_db -d -p 8000:8000 --name=$name cnadiminti/dynamodb-local:latest
            ;;

        stop)
            stop
            ;;

        connect)
            echo "Attempting to connect ....."
            CONTAINERID=`docker ps | grep w4156 | cut -d" " -f1`
            if [ -z ${CONTAINERID} ];
            then
                echo "   Container not found. Unable to Connect"
            else
                echo "Connecting to container:$CONTAINERID"
                docker exec -it $CONTAINERID bash
            fi
            ;;

        *)
        echo $"Usage: $0 {pull|start|stop}"
        exit 1

esac

