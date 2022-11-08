FROM oraclelinux:8 AS oracle8

#Installing ROOT and dependencies

RUN yum install -y epel-release

RUN yum install -y git cmake3 gcc-c++ gcc binutils compat-openssl10 \
libX11-devel libXpm-devel libXft-devel libXext-devel openssl-devel wget bzip2-devel libffi-devel xz-devel sqlite-devel ncurses ncurses-devel make xz libzstd libzstd-devel

RUN cd /opt && wget https://root.cern/download/root_v6.26.06.Linux-centos8-x86_64-gcc8.5.tar.gz && tar -xzvf root_v6.26.06.Linux-centos8-x86_64-gcc8.5.tar.gz && \
    rm root_v6.26.06.Linux-centos8-x86_64-gcc8.5.tar.gz && echo ". /opt/root/bin/thisroot.sh" >> ~/.bashrc

#RUN yum install -y make cfitsio cfitsio-devel && cp /usr/include/cfitsio/* /usr/include/ 
#RUN yum install -y gsl && yum install -y gsl-devel 
RUN cd /usr/src && wget http://heasarc.gsfc.nasa.gov/FTP/software/fitsio/c/cfitsio-4.1.0.tar.gz && tar -xzvf cfitsio-4.1.0.tar.gz && cd cfitsio-4.1.0 && ./configure --prefix=/usr/ && make && make install

#RUN wget http://springdale.princeton.edu/data/springdale/7/x86_64/os/Computational/gsl26-2.6-3.sdl7.2.x86_64.rpm && \
#    yum install -y gsl26-2.6-3.sdl7.2.x86_64.rpm && rm gsl26-2.6-3.sdl7.2.x86_64.rpm && \
#    wget http://springdale.princeton.edu/data/springdale/7/x86_64/os/Computational/gsl26-devel-2.6-3.sdl7.2.x86_64.rpm && \
#    yum install -y gsl26-devel-2.6-3.sdl7.2.x86_64.rpm && rm gsl26-devel-2.6-3.sdl7.2.x86_64.rpm && cp -rf /usr/local/gsl/2.6/x86_64/lib64 /usr/local/gsl/2.6/x86_64/lib
    

#Installing science tools
#GSL=$PREFIX/usr/local/gsl/2.6/x86_64/ env if GSL is installed
ENV PREFIX=/
ENV CFITSIO=$PREFIX/usr/ AGILE=$PREFIX/agiletools GSL="" \
    C_INCLUDE_PATH=$PREFIX/usr/include CPP_INCLUDE_PATH=$PREFIX/usr/include ZLIBPATH=$PREFIX/lib AGILE=$PREFIX/agiletools

ENV PFILES=$PFILES:$AGILE/share LD_LIBRARY_PATH=$PREFIX/lib:$PREFIX/lib64:$GSL/lib:/usr/lib64:usr/lib:$LD_LIBRARY_PATH PATH=$AGILE/bin:$AGILE/scripts:$PATH

RUN source /opt/root/bin/thisroot.sh && mkdir $PREFIX/agiletools && cd $PREFIX/agiletools && git clone https://github.com/AGILESCIENCE/AGILE-GRID-ScienceTools-Setup.git \
    && cd AGILE-GRID-ScienceTools-Setup && git checkout BUILD25b3 && ./downloadScienceTools.sh && ./installScienceTools.sh && ./downloadIRF.sh && ./installIRF.sh \
    && rm -rf $AGILE/AGILE-GRID-ScienceTools-Setup
 
ENV PFILES=$PFILES:$AGILE/share PATH=$AGILE/bin:$AGILE/scripts:$AGILE/scripts/extendesources:$PATH LD_LIBRARY_PATH=$GSL/lib64:$PREFIX/lib:$PREFIX/lib64:$AGILE/lib:$LD_LIBRARY_PATH

#installing python and agilepy

SHELL ["/bin/bash", "--login", "-c"]

RUN cd /usr/src && \
    wget https://www.python.org/ftp/python/3.8.13/Python-3.8.13.tar.xz && \
    tar -xvf Python-3.8.13.tar.xz && \
    cd Python-3.8.13 && \
    ./configure --prefix=/opt/python3 && \
    make altinstall && \
    ln -sf /opt/python3/bin/python3.8 /usr/bin/python3 && \
    python3 -m venv /opt/venv/agilepy

RUN mkdir -p $AGILE/agilepy-test-data && \
    cd $AGILE/agilepy-test-data && \
    wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1B31SCrHoOU0KnZoaZ7NTq6nY_PTD-ner' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1B31SCrHoOU0KnZoaZ7NTq6nY_PTD-ner" -O test_dataset_6.0.tar.gz && rm -rf /tmp/cookies.txt && \
    tar -xzf test_dataset_6.0.tar.gz && \
    rm test_dataset_6.0.tar.gz && \
    wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1B3Tp-01-X7Cwh6lq11BUCiaHuctj0iDW' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1B3Tp-01-X7Cwh6lq11BUCiaHuctj0iDW" -O test_dataset_agn.tar.gz && rm -rf /tmp/cookies.txt && \
    tar -xzf test_dataset_agn.tar.gz && \
    rm test_dataset_agn.tar.gz

RUN source /opt/venv/agilepy/bin/activate && cd / && \
    git clone https://github.com/AGILESCIENCE/Agilepy-recipe.git && \
    cd Agilepy-recipe//recipes/docker/base/ && \
    pip install -r requirements.txt && \
    echo "source /opt/venv/agilepy/bin/activate && jupyter notebook --ip='*' --port=8888 --no-browser --allow-root" >> /start_notebook.sh
ENV PYTHONPATH=$AGILE/scripts/:$PYTHONPATH
