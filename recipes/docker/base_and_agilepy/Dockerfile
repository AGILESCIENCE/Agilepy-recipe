FROM agilescience/base_image


RUN conda activate agilepydev && cd / && \
    git clone https://github.com/AGILESCIENCE/Agilepy.git && \
    cd Agilepy && git checkout develop && \
    python setup.py develop


