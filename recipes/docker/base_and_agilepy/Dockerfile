FROM agilescience/agilepy-recipe:latest


RUN source /opt/venv/agilepy/bin/activate && cd / && \
    git clone https://github.com/AGILESCIENCE/Agilepy.git && \
    cd Agilepy && git checkout develop && \
    python setup.py develop

