#!/bin/bash

if [ "$#" -ne 2 ]; then
    printf "Illegal number of parameters. Arguments: \n  type: local, gh\n  agilepy_tag\n"
else

  type="$1"

  export AGILEPY_TAG="$2"
  export PACKAGE_TAG="$2"

  if [ "$type" = "local" ]; then
    echo "Local build"
    folder="./"
  else
    echo "Devops build"
    folder="./github-workflow-build"
  fi


  conda-build "$folder"
fi
