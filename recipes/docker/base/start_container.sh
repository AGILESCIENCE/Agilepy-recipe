#!/bin/bash

if [ "$#" -ne 2 ]; 
then
    printf "Error: illegal number of parameters, Usage: start.sh container_type(base | agilepy) tag_name \nExample: source start_container.sh base latest \n"
else

TAG_NAME="$2"

if [ "$1" = "base" ]; 
then
    REPO="agilescience/agilepy-recipe"
elif [ "$1" = "agilepy" ];
then
    REPO="agilescience/agilepy"
else
    echo "repo not valid"
    exit 1
fi

mkdir -p shared_dir &&

docker run --rm -it -p 8888:8888 \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    -v $PWD/shared_dir:/shared_dir \
    $REPO:$TAG_NAME
fi