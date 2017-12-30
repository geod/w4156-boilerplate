#!/bin/bash

name=dynamo
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
        build)
            docker build -t w4156:latest .
            ;;

        start)
            stop
            echo "Removing previous container for $name"
            docker rm $(docker ps -aq --filter name=$name)
            echo "Starting Container ...."
	        docker run -d -p 5000:5000 --link dynamo:dynamo --name=$name w4156
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

        bash)
            stop
            echo "Starting new instance to bash into (note this is not running flask) ...."
            docker run -i -t --link dynamo:dynamo --rm --entrypoint /bin/bash w4156
            ;;

        runtests)
            docker run --interactive --tty w4156 'bin/tests_run.sh'
            ;;

        *)
        echo $"Usage: $0 {start|stop|bash|runtests}"
        exit 1

esac

