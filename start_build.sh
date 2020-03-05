#!/bin/bash

if [ "$#" -ne 3 ]; then
    printf "Illegal number of parameters. Arguments: \n  type: local, gh\n  agilepy_tag\n  science_tools_tag\n"
    exit
fi

type="$1"
agilepy_tag="$2"
science_tools_tag="$3"


if [ "$type" = "local" ]; then
  echo "Local build"
  folder="./local-build"
else
  echo "Devops build"
  folder="./github-workflow-build"
fi

echo "Agilepy tag: $agilepy_tag"
echo "Science tools tag: $science_tools_tag"

cp "$folder/meta.yaml.template" "$folder/meta.yaml"
rc=$?; if [[ "$rc" != 0 ]]; then exit "$rc"; fi

sed 's/{{agilepy_tag}}/'"$agilepy_tag"'/' -i "$folder/meta.yaml"
rc=$?; if [[ "$rc" != 0 ]]; then exit "$rc"; fi

sed 's/{{package_tag}}/'"$agilepy_tag"'/' -i "$folder/meta.yaml"
rc=$?; if [[ "$rc" != 0 ]]; then exit "$rc"; fi

sed 's/{{science_tools_tag}}/'"$science_tools_tag"'/' -i "$folder/meta.yaml"
rc=$?; if [[ "$rc" != 0 ]]; then exit "$rc"; fi


cp "$folder/build.sh.template" "$folder/build.sh"

sed 's/{{science_tools_tag}}/'"$science_tools_tag"'/' -i "$folder/build.sh"
rc=$?; if [[ "$rc" != 0 ]]; then exit "$rc"; fi


conda-build "$folder"

# cleanup
rm "$folder/meta.yaml"
rm "$folder/build.sh"
