#!/bin/bash

if [ "$#" -ne 3 ]; then
    printf "Illegal number of parameters. Arguments: \n  type: local, gh\n  agilepy_tag\n  science_tools_tag\n"
else

  type="$1"

  export AGILEPY_TAG="$2"
  export PACKAGE_TAG="$2"
  export SCIENCE_TOOLS_TAG="$3"


  if [ "$type" = "local" ]; then
    echo "Local build"
    folder="./local-build"
  else
    echo "Devops build"
    folder="./github-workflow-build"
  fi


  conda-build "$folder"
fi
