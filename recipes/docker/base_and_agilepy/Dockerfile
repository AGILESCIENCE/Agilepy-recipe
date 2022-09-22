FROM agilescience/agilepy-recipe:BUILD25b1


RUN source /opt/venv/agilepy/bin/activate && cd / && \
    git clone https://github.com/AGILESCIENCE/Agilepy.git && \
    cd Agilepy && git checkout develop && \
    python setup.py develop

