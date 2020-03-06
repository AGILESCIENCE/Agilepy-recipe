#!/bin/bash

if [ "$#" -ne 1 ]; then
    printf "Illegal number of parameters. \n\n > bash start_build.sh BUILD25ag \n"
else

  export SCIENCE_TOOLS_TAG="$1"

  folder="./local-build"

  conda-build "$folder"

fi
