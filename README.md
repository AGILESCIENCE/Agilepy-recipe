# Agilepy-recipe
This repository containes the recipes to build the Docker container of Agilepy.

For Docker :
* [base images](https://hub.docker.com/repository/docker/agilescience/agilepy-recipe)
* [base+Agilepy](https://hub.docker.com/repository/docker/agilescience/agilepy)


## Building the Docker images

### Base image
This Dockerfile starts from an oracle8 image and installs all the low and high level dependencies required by Agilepy. The AGILE tools are installed from source. It can be used as develop environment. 

Build the base image and push it to DockerHub. [Tags here](https://hub.docker.com/r/agilescience/agilepy-recipe/tags)
```
cd recipes/docker/base
docker build --tag agilescience/agilepy-recipe:<tagname> .
docker login
docker push agilescience/agilepy-recipe:<tagname>
```

#### Environment updates
Agilepy's dependencies are locked to provide a stable environment. When a new dependnecy is added to the requirements.txt, the [requirements.lock](recipes/docker/base/requirements.lock) file must be regenerated with:
```bash
pip-compile --resolver=backtracking --no-annotate --output-file requirements.lock requirements.txt
```
`pip-compile` (>=6.12.3) can be installed with
```bash
pip install pip-tools
```
If you want to update a package, regenerate the .lock file using the `--upgrade-package PACKAGE` option.

### Agilepy image
Add to the base image a specific release of Agilepy and push it to the DockerHub. [Agilepy releases here](https://github.com/AGILESCIENCE/Agilepy/tags)

```
cd recipes/docker/agilepy
docker build --build-arg BASE_VERSION=<base-version> --build-arg AGILEPY_RELEASE=<agilepy-release> --tag agilescience/agilepy:release-<agilepy-release> .
docker login
docker push agilescience/agilepy:<agilepy-release>
```


## Building the conda packages (deprecated)

For Anaconda the following packages are available on the Anaconda Cloud:
* [agiletools](https://anaconda.org/agilescience/agiletools)
* [agilepy-dataset](https://anaconda.org/agilescience/agilepy-dataset)
* [agilepy](https://anaconda.org/agilescience/agilepy)

### agiletools

This package contains the AGILE science tools. They are downloaded and installed using the [AGILE-GRID-ScienceTools-Setup](https://github.com/AGILESCIENCE/AGILE-GRID-ScienceTools-Setup) repository.

### agilepy-dataset

This package contains two datasets, extracted from the AGILE data archive. They are used within the Agilepy software for testing purposes and for developing several Agilepy's tutorials.    

### agilepy

This package contains the [Agilepy](https://github.com/AGILESCIENCE/Agilepy) software. The agiletools version in meta.yaml must be updated to the latest one available on Anaconda Coud.

### Uploading the package
Login to anaconda cloud:
```bash
anaconda login
```
Upload the package with:
```bash
anaconda upload <path-to-package>
```
The *<path-to-package>* is written on the console at the end of the *conda-build* command.

Update conda and install and update *conda-build*:
```
conda update conda
conda install conda-build
conda update conda-build
```
Add the required channels.
```bash
conda config --add channels conda-forge
conda config --add channels plotly
```

Build the anaconda packages:
```bash
source recipes/anaconda/science-tools/start_build.sh <agile-st-tag>
source recipes/anaconda/agilepy-dataset/start_build.sh <agile-st-tag>
source recipes/anaconda/agilepy/start_build.sh local <agilepytag>
```



## Troubleshooting

### The command *anaconda login* is not found
Be sure to use the *anaconda Command line client*.
```bash
anaconda --version
anaconda Command line client (version 1.7.2)
```
and not
```bash
anaconda --version
anaconda 21.48.22.156-1
```

