FROM jupyter/scipy-notebook:ubuntu-20.04

USER root

### Providing root privileges to default "jovyan" user account
RUN echo "jovyan ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER jovyan

### OS Packages installation
RUN sudo apt-get update && sudo apt-get install aptitude \
    gdebi-core \
    curl \
    wget \
    tar \
    software-properties-common \
    build-essential \
    dirmngr \
    libxml2-dev \
    libcurl4-openssl-dev \
    libfontconfig1-dev \
    libssl-dev \
    libsodium-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libfreetype6-dev \
    libpng-dev \
    libtiff5-dev \
    libjpeg-dev \
    libfontconfig1-dev \
    libgsl-dev \
    libudunits2-dev \
    libprotobuf-dev \
    libjq-dev \
    libmagick++-dev \
    cmake \
    make \
    gfortran \
    default-jre \
    default-jdk \
    cron \
    screen \
    libgmp3-dev \
    libmpfr-dev -y

## GDAL installation
RUN sudo add-apt-repository ppa:ubuntugis/ppa
RUN sudo apt-get install libgdal-dev libproj-dev -y

### gsutil installation
RUN sudo echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add - && sudo apt-get update -y && sudo apt-get install google-cloud-cli -y

### R installation - https://cran.r-project.org/bin/linux/ubuntu/#acknowledgements
RUN wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
RUN sudo add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"
## Adding c2d4u - a project for automatically converting CRAN packages for R into Debian packages and being able to install them with "apt-get install r-cran-<package>"
# RUN sudo add-apt-repository ppa:c2d4u.team/c2d4u4.0+ -y

RUN sudo apt-get install r-base -y

## Rstudio server installation (It is running under R kernel)
RUN cd /tmp && \
    wget https://download2.rstudio.org/server/bionic/amd64/rstudio-server-2022.12.0-353-amd64.deb && \
    sudo gdebi rstudio-server-2022.12.0-353-amd64.deb -n
ENV PATH=$PATH:/usr/lib/rstudio-server/bin

RUN sudo R -e "install.packages(c('devtools', 'IRkernel'), dependencies=TRUE, repos='http://cran.rstudio.com/', Ncpus = 4)"
## Install R kernel to jupyterlab
RUN R -e "IRkernel::installspec()"

## Rstudio server Jupyter plugin installation
RUN python3 -m pip install jupyter-rsession-proxy
RUN pip install jupyter-server-proxy

### NCO installation
RUN sudo aptitude install nco -y

### CROP models installation
## DSSAT installation
RUN sudo mkdir -p /opt/DSSAT/v4.7.5.30 && \
    sudo chown -R jovyan:users /opt/DSSAT/v4.7.5.30/.

RUN sudo mkdir -p /opt/DSSAT/v4.8.1.40 && \
    sudo chown -R jovyan:users /opt/DSSAT/v4.8.1.40/.

# v4.7.5.30 installation
RUN cd /opt/DSSAT/v4.7.5.30 && \
    git clone https://github.com/DSSAT/dssat-csm-os.git --depth 1 --branch v4.7.5.30 && \
    git clone https://github.com/DSSAT/dssat-csm-data.git

RUN cd /opt/DSSAT/v4.7.5.30/dssat-csm-os && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make

# Adjusting filesystem to DSSAT compiler requirements
RUN cp /opt/DSSAT/v4.7.5.30/dssat-csm-os/build/bin/* /opt/DSSAT/v4.7.5.30
RUN cp -r /opt/DSSAT/v4.7.5.30/dssat-csm-os/Data/. /opt/DSSAT/v4.7.5.30
RUN cp -r /opt/DSSAT/v4.7.5.30/dssat-csm-data/* /opt/DSSAT/v4.7.5.30
RUN sed -i 's,/usr/local,opt/DSSAT/v4.7.5.30,g' /opt/DSSAT/v4.7.5.30/DSSATPRO.L47
RUN chown -R jovyan:users /opt/DSSAT/v4.7.5.30/*

# v4.8.1.40 installation
RUN cd /opt/DSSAT/v4.8.1.40  && \
    git clone https://github.com/DSSAT/dssat-csm-os.git --depth 1 --branch v4.8.1.40  && \
    git clone https://github.com/DSSAT/dssat-csm-data.git

RUN cd /opt/DSSAT/v4.8.1.40/dssat-csm-os && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make

# Adjusting filesystem to DSSAT compiler requirements
RUN cp /opt/DSSAT/v4.8.1.40/dssat-csm-os/build/bin/* /opt/DSSAT/v4.8.1.40
RUN cp -r /opt/DSSAT/v4.8.1.40/dssat-csm-os/Data/. /opt/DSSAT/v4.8.1.40
RUN cp -r /opt/DSSAT/v4.8.1.40/dssat-csm-data/* /opt/DSSAT/v4.8.1.40
RUN sed -i 's,/usr/local,opt/DSSAT/v4.8.1.40,g' /opt/DSSAT/v4.8.1.40/DSSATPRO.L48
RUN chown -R jovyan:users /opt/DSSAT/v4.8.1.40/*

# ApsimX
RUN sudo mkdir -p /opt/APSIM/ && sudo chown -R jovyan:users /opt/APSIM/
RUN cd /tmp && sudo wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
RUN cd /tmp && sudo dpkg -i packages-microsoft-prod.deb
RUN sudo apt-get update
RUN sudo apt-get install dotnet-sdk-3.1 -y
RUN cd /opt/APSIM && git clone https://github.com/APSIMInitiative/ApsimX
RUN cd /opt/APSIM/ApsimX && git reset --hard 22c438c5848dd9f141a33e06124e725b9c899f04
RUN sudo chown -R jovyan:users /opt/APSIM/*
RUN cd /opt/APSIM/ApsimX && dotnet build -c Release ApsimX.sln
RUN sudo chown -R jovyan:users /opt/APSIM/*

### Jupyter extensions & plugins installation
RUN pip install aquirdturtle_collapsible_headings
RUN pip install jupyterlab-spellchecker
RUN pip install --upgrade jupyterlab jupyterlab-git
RUN pip install jupyterlab_code_formatter
RUN pip install lckr-jupyterlab-variableinspector
RUN pip install jupyterlab_execute_time
RUN pip install jupyterlab-hide-code
RUN pip install 'jupyterlab>=3.0.0,<4.0.0a0' jupyterlab-lsp
RUN pip install jupyterlab-geojson
RUN pip install jupyterlab-fasta
RUN pip install jupyterlab-drawio
RUN pip install jupyter-archive

### R packages installation
COPY . .
## rJava dependencies
RUN sudo R CMD javareconf

RUN sudo Rscript packages.R

## Geospatial Python libraries
### Python packages installation
RUN conda install -c conda-forge --file requirements.txt -y
RUN rm packages.R requirements.txt
