FROM centos:7

#Installing ROOT and dependencies

RUN yum install -y git cmake3 gcc-c++ gcc binutils \
libX11-devel libXpm-devel libXft-devel libXext-devel openssl-devel wget

RUN yum install -y epel-release
RUN yum install -y root make gsl gsl-devel conda cfitsio cfitsio-devel && cp /usr/include/cfitsio/* /usr/include/

#Installing science tools

ENV PREFIX=/
ENV CFITSIO=$PREFIX/usr/ ROOTSYS=/lib64/root/ AGILE=$PREFIX/agiletools GSL=$PREFIX/usr/ \
    C_INCLUDE_PATH=$PREFIX/usr/include CPP_INCLUDE_PATH=$PREFIX/usr/include ZLIBPATH=$PREFIX/lib AGILE=$PREFIX/agiletools

ENV PFILES=$PFILES:$AGILE/share LD_LIBRARY_PATH=$PREFIX/lib:$LD_LIBRARY_PATH PATH=$AGILE/bin:$AGILE/scripts:$PATH

RUN mkdir $PREFIX/agiletools && cd $PREFIX/agiletools && git clone https://github.com/AGILESCIENCE/AGILE-GRID-ScienceTools-Setup.git \
    && cd AGILE-GRID-ScienceTools-Setup && git checkout BUILD25ag && ./downloadScienceTools.sh && ./installScienceTools.sh && ./downloadIRF.sh && ./installIRF.sh \
    && rm -rf $AGILE/AGILE-GRID-ScienceTools-Setup
 
ENV PFILES=$PFILES:$AGILE/share PATH=$AGILE/bin:$AGILE/scripts:$AGILE/scripts/extendesources:$PATH LD_LIBRARY_PATH=$PREFIX/lib:$PREFIX/lib64:$AGILE/lib:$LD_LIBRARY_PATH

#Installing agilepy

SHELL ["/bin/bash", "--login", "-c"]

RUN mkdir -p $AGILE/agilepy-test-data && \
    cd $AGILE/agilepy-test-data && \
    wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1B31SCrHoOU0KnZoaZ7NTq6nY_PTD-ner' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1B31SCrHoOU0KnZoaZ7NTq6nY_PTD-ner" -O test_dataset_6.0.tar.gz && rm -rf /tmp/cookies.txt && \
    tar -xzf test_dataset_6.0.tar.gz && \
    rm test_dataset_6.0.tar.gz && \
    wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1B3Tp-01-X7Cwh6lq11BUCiaHuctj0iDW' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1B3Tp-01-X7Cwh6lq11BUCiaHuctj0iDW" -O test_dataset_agn.tar.gz && rm -rf /tmp/cookies.txt && \
    tar -xzf test_dataset_agn.tar.gz && \
    rm test_dataset_agn.tar.gz && \
    conda activate base && conda config --add channels conda-forge && \
    conda config --add channels plotly && \
    conda create -n agilepydev && \
    conda activate agilepydev && cd / &&\
    git clone https://github.com/AGILESCIENCE/Agilepy.git && \
    cd Agilepy && git checkout develop && \
    conda env update -f environment.yml && \
    python setup.py develop

