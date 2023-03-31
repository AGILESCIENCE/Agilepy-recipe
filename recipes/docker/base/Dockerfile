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

# Install Ruby 1.9 (does not compile)
#RUN wget https://cache.ruby-lang.org/pub/ruby/1.9/ruby-1.9.0-0.tar.gz && \
#    tar -xzvf ruby-1.9.0-0.tar.gz && \
#    cd ruby-1.9.0-0 && \
#    ./configure --prefix=/usr/local && \
#    make && \
#    make install && \
#    rm -rf /usr/src/ruby-1.9.0-0.tar.gz
# Fallback to 2.5.9
RUN yum install -y ruby



# ---------------------------------- Create Agilepy user ---------------------------------- 
RUN useradd flareadvocate
USER flareadvocate
WORKDIR /home/flareadvocate

SHELL ["/bin/bash", "--login", "-c"]


# ---------------------------------- Installing science tools ---------------------------------- 
#GSL=$PREFIX/usr/local/gsl/2.6/x86_64/ env if GSL is installed
ENV PREFIX=/home/flareadvocate
ENV CFITSIO=$PREFIX/usr/ AGILE=$PREFIX/agiletools GSL="" \
    C_INCLUDE_PATH=$PREFIX/usr/include CPP_INCLUDE_PATH=$PREFIX/usr/include ZLIBPATH=$PREFIX/lib AGILE=$PREFIX/agiletools

ENV PFILES=$PFILES:$AGILE/share LD_LIBRARY_PATH=$PREFIX/lib:$PREFIX/lib64:$GSL/lib:/usr/lib64:usr/lib:$LD_LIBRARY_PATH PATH=$AGILE/bin:$AGILE/scripts:$PATH

RUN source /opt/root/bin/thisroot.sh && mkdir $PREFIX/agiletools && cd $PREFIX/agiletools && git clone https://github.com/AGILESCIENCE/AGILE-GRID-ScienceTools-Setup.git \
    && cd AGILE-GRID-ScienceTools-Setup && git checkout BUILD25b3 && ./downloadScienceTools.sh && ./installScienceTools.sh && ./downloadIRF.sh && ./installIRF.sh \
    && rm -rf $AGILE/AGILE-GRID-ScienceTools-Setup
 
ENV PFILES=$PFILES:$AGILE/share PATH=$AGILE/bin:$AGILE/scripts:$AGILE/scripts/extendesources:$PATH LD_LIBRARY_PATH=$GSL/lib64:$PREFIX/lib:$PREFIX/lib64:$AGILE/lib:$LD_LIBRARY_PATH

# ----------------------------------  Installing Python and create a virtual environment ---------------------------------- 
RUN mkdir -p /home/flareadvocate/tmp
RUN cd /home/flareadvocate/tmp && \
    wget https://www.python.org/ftp/python/3.8.13/Python-3.8.13.tar.xz && \
    tar -xvf Python-3.8.13.tar.xz && \
    cd Python-3.8.13 && \
    ./configure --prefix=/home/flareadvocate/python3 && \
    make altinstall && \
    /home/flareadvocate/python3/bin/python3.8 -m venv /home/flareadvocate/venv/agilepy

RUN /home/flareadvocate/venv/agilepy/bin/python3.8 -m pip install --upgrade pip

USER root
RUN  ln -sf /home/flareadvocate/python3/bin/python3.8 /usr/bin/python3
RUN chown -R flareadvocate:flareadvocate $AGILE
RUN rm -rf /home/flareadvocate/tmp
USER flareadvocate

# ----------------------------------  Download the test dataset ---------------------------------- 

RUN mkdir -p $AGILE/agilepy-test-data && \
    cd $AGILE/agilepy-test-data && \
    wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1B31SCrHoOU0KnZoaZ7NTq6nY_PTD-ner' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1B31SCrHoOU0KnZoaZ7NTq6nY_PTD-ner" -O test_dataset_6.0.tar.gz && rm -rf /tmp/cookies.txt && \
    tar -xzf test_dataset_6.0.tar.gz && \
    rm test_dataset_6.0.tar.gz && \
    wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1B3Tp-01-X7Cwh6lq11BUCiaHuctj0iDW' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1B3Tp-01-X7Cwh6lq11BUCiaHuctj0iDW" -O test_dataset_agn.tar.gz && rm -rf /tmp/cookies.txt && \
    tar -xzf test_dataset_agn.tar.gz && \
    rm test_dataset_agn.tar.gz

#  ---------------------------------- Installing Agilepy Recipe ----------------------------------
COPY requirements.lock /tmp
RUN source /home/flareadvocate/venv/agilepy/bin/activate && cd /home/flareadvocate && \
    pip install -r /tmp/requirements.lock

# add virtual environment activation in .bashrc
RUN echo "source /home/flareadvocate/venv/agilepy/bin/activate" >> /home/flareadvocate/.bashrc

ENV PYTHONPATH=$AGILE/scripts/:$PYTHONPATH
ENV PATH=$AGILE/scripts:/home/flareadvocate/python3/bin:$PATH
