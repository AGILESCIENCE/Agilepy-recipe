# Agilepy-recipe
This repository containes the recipes to build the Anaconda packages and the Docker container of Agilepy.

For Anaconda the following packages are available on the Anaconda Cloud:
* [agiletools](https://anaconda.org/agilescience/agiletools)
* [agilepy-dataset](https://anaconda.org/agilescience/agilepy-dataset)
* [agilepy](https://anaconda.org/agilescience/agilepy)


For Docker :
* [base images](https://hub.docker.com/repository/docker/agilescience/agilepy-recipe)
* [base+Agilepy](https://hub.docker.com/repository/docker/agilescience/agilepy)

The Docker image uses venv as virtual environment

## Building the conda packages

### Anaconda Recipes
#### agiletools

This package contains the AGILE science tools. They are downloaded and installed using the [AGILE-GRID-ScienceTools-Setup](https://github.com/AGILESCIENCE/AGILE-GRID-ScienceTools-Setup) repository.
#### agilepy-dataset

This package contains two datasets, extracted from the AGILE data archive. They are used within the Agilepy software for testing purposes and for developing several Agilepy's tutorials.    
#### agilepy

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

## Building the Docker containers


Build the base image push to the DockerHub:
```
cd recipes/docker/base
docker build --tag agilescience/agilepy-recipe:<tagname> .
docker push agilescience/agilepy-recipe:<tagname>
```

Build base image + Agilepy and push to the DockerHub:
```
cd recipes/docker/base_and_agilepy
docker build --build-arg TAG=<tagname> --tag agilescience/agilepy:release-<tagname> .
docker push agilescience/agilepy:<tagname>
```

### Dockerfiles
#### base_image
This dockerfile starts from an oracle8 images and installs all the low and high level dependencies required by Agilepy, AGILE tools are installed from source. It can be used as develop environment.
#### base_and_agilepy
Starting from the base_image it clones the Agilepy repository and install it inside the container.

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

