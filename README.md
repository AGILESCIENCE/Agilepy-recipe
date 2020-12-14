# Agilepy-recipe

## Building the conda packages
Install *conda-build*:
```
conda install conda-build
conda update conda-build
```
Add the required channels.
```bash
conda config --add channels conda-forge
conda config --add channels plotly
```
Download this repo:
```bash
git clone https://github.com/AGILESCIENCE/Agilepy-recipe.git
cd Agilepy-recipe/agilepy
```
Run:
```bash
bash start_build.sh local 1.0.0 BUILD25ag
```
The script will build a package, using the tag 1.0.0 of [Agilepy](https://github.com/AGILESCIENCE/Agilepy) and the tag BUILD25ag of [AGILE-GRID-ScienceTools-Setup](https://github.com/AGILESCIENCE/AGILE-GRID-ScienceTools-Setup). Please, verify that the Agilepy version you provide is compatible with the version of the ScienceTools (you can check the "sciencetools_version.txt" file in the root of the Agilepy project).

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

