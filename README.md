# Agilepy-recipe
This repository containes several recipes to build the following anaconda packages:
* agiletools
* agilepy-dataset
* agilepy

## Building the conda packages
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
Run:
```bash
source recipes/agiletools/start_build.sh BUILD25ag
source recipes/agilepy-dataset/start_build.sh BUILD25ag
source recipes/agiletools/start_build.sh local <agilepy commit-id, tag or branch> BUILD25ag
```

## Recipes

### agiletools
This package contains the AGILE science tools. They are downloaded and installed using the [AGILE-GRID-ScienceTools-Setup](https://github.com/AGILESCIENCE/AGILE-GRID-ScienceTools-Setup) repository.

### agilepy-dataset
This package contains two datasets, extracted from the AGILE data archive. They are used within the Agilepy software for testing purposes and for developing several Agilepy's tutorials.    

### agilepy
This package contains the [Agilepy](https://github.com/AGILESCIENCE/Agilepy) software. 

## Uploading the package
Login to anaconda cloud:
```bash
anaconda login
```
Upload the package with:
```bash
anaconda upload <path-to-package>
```
The *<path-to-package>* is written on the console at the end of the *conda-build* command.

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

