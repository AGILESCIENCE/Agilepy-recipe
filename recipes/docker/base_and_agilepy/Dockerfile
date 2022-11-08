FROM agilescience/agilepy-recipe:BUILD25b3626

ARG TAG

RUN source /opt/venv/agilepy/bin/activate && cd / && \
    git clone https://github.com/AGILESCIENCE/Agilepy.git && \
    cd Agilepy && git checkout $TAG && \
    python setup.py develop

