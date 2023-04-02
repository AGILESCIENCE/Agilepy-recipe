ARG BASE_VERSION
FROM agilescience/agilepy-recipe:${BASE_VERSION}

WORKDIR /home/flareadvocate

RUN git clone https://github.com/AGILESCIENCE/Agilepy.git 
ARG AGILEPY_RELEASE
RUN cd Agilepy && git switch ${AGILEPY_RELEASE}
RUN source venv/agilepy/bin/activate && cd Agilepy && pip install .

USER root
RUN  mkdir /shared_dir
RUN chown -R flareadvocate:flareadvocate /shared_dir
COPY ./entrypoint.sh /home/flareadvocate/entrypoint.sh
RUN chmod +x /home/flareadvocate/entrypoint.sh


USER flareadvocate
ENTRYPOINT ["/home/flareadvocate/entrypoint.sh"]