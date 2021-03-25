#!/bin/bash

mkdir -p shared_dir &&

docker run --rm -it -p 8888:8888 \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    -v $PWD/shared_dir:/shared_dir \
    agilescience/agilepy:develop-latest