# Changelog
31/03/2023: the requirements.txt has been locked with pip-compile.
30/03/2023: the base image has been refactored. Only yum dependencies are installed as root. The other software is compiled and installed with the 'flareadvocate' user.