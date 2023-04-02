#!/bin/bash
printf "Starting Jupyter Notebook Server...\n"
printf "Python3 path: $(which python3)\n"
$HOME/venv/agilepy/bin/python3 -m jupyter notebook --ip=\"*\" --port=8888 --no-browser --allow-root --notebook-dir=/shared_dir