#!/bin/bash

if [ "$#" -ne 3 ]; then
    printf "Illegal number of parameters. Arguments: \n  type: local, gh\n  agilepy_version\n  science_tools_version\n"
    return;
fi

type="$1"
agilepy_version="$2"
science_tools_version="$3"


if [ "$type" = "local" ]; then
  echo "Local build"
  folder="./local-build"
else
  echo "Devops build"
  folder="./github-workflow-build"
fi

echo "Agilepy tag: $agilepy_version"
echo "Science tools tag: $science_tools_version"

cp $folder/meta.yaml.template $folder/meta.yaml
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

sed 's/{{agilepy_version}}/'"$agilepy_version"'/' -i $folder/meta.yaml
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

sed 's/{{package_version}}/'"$agilepy_version"'/' -i $folder/meta.yaml
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi


cp $folder/build.sh.template $folder/build.sh

sed 's/{{science_tools_tag}}/'"$science_tools_version"'/' -i $folder/build.sh
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

conda-build $folder

# cleanup
rm $folder/meta.yaml
rm $folder/build.sh
