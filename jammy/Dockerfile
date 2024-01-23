FROM jupyter/scipy-notebook:ubuntu-22.04

USER root

### Providing root privillages to default "jovyan" user account
RUN echo "jovyan ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER jovyan

### OS Packages installation
RUN sudo apt-get update && sudo apt-get install aptitude gdebi-core curl wget tar build-essential cmake make default-jre default-jdk cron screen pkg-config protobuf-compiler \
    libfontconfig1-dev libgsl-dev libudunits2-dev libprotobuf-dev libjq-dev libmagick++-dev gfortran fftw3 fftw3-dev libxml2-dev libcurl4-openssl-dev libfontconfig1-dev libssl-dev \
    libsodium-dev libharfbuzz-dev libfribidi-dev libfreetype6-dev libpng-dev libtiff5-dev libjpeg-dev libgmp3-dev libmpfr-dev libarchive-dev libproj-dev libgeos-dev gnupg nco \
    gcc g++ libsqlite3-dev sqlite3 dotnet-sdk-6.0 proj-bin -y

### R installation - https://cran.r-project.org/bin/linux/ubuntu/#acknowledgements
RUN sudo apt install --no-install-recommends software-properties-common dirmngr -y && \
    wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc && \
    sudo add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/" && \
    sudo apt install --no-install-recommends r-base -y

## Installing R kernel to jupyterlab
RUN sudo R -e "install.packages('IRkernel')"
RUN R -e "IRkernel::installspec()"

## Rstudio server installation (It is running under R kernel - https://posit.co/download/rstudio-server/)
RUN echo "deb http://security.ubuntu.com/ubuntu focal-security main" | sudo tee /etc/apt/sources.list.d/focal-security.list && \
    sudo apt-get update && \
    sudo apt-get install libssl1.1 -y

RUN cd /tmp && \
    wget https://download2.rstudio.org/server/focal/amd64/rstudio-server-2023.09.0-463-amd64.deb && \
    sudo gdebi -n rstudio-server-2023.09.0-463-amd64.deb

ENV PATH=$PATH:/usr/lib/rstudio-server/bin

## Rstudio server Jupyter plugin installation
RUN python3 -m pip install jupyter-rsession-proxy
RUN pip install jupyter-server-proxy

### gsutil installation
RUN sudo echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add - && sudo apt-get update -y && sudo apt-get install google-cloud-cli -y

### GDAL installation
ENV GDAL_VERSION=3.8.3

RUN wget https://github.com/OSGeo/gdal/releases/download/v${GDAL_VERSION}/gdal-${GDAL_VERSION}.tar.gz && \
    tar -xvf gdal-${GDAL_VERSION}.tar.gz && \
    sudo mv gdal-${GDAL_VERSION} /opt && \
    cd /opt/gdal-${GDAL_VERSION} && \
    sudo mkdir build && \
    cd build && \
    sudo cmake .. && \
    sudo cmake --build . && \
    sudo cmake --build . --target install

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

## ApsimX
RUN cd /opt/ && \
    sudo git clone https://github.com/APSIMInitiative/ApsimX && \
    sudo chown -R jovyan:users /opt/ApsimX/. && \
    dotnet build -c Release ./ApsimX/ApsimX.sln

## rJava dependencies
RUN sudo R CMD javareconf

# From here on: 3 cores: 48m2s, 4 cores 38m4s, 6 cores 37m3s
RUN sudo Rscript packages.R

### Python packages installation
RUN pip install -r jupyterlab.requirments.txt
RUN conda install -c conda-forge --file requirements.txt -y

### Copying .bashrc of default $HOME directory to /opt
RUN sudo cp .bashrc /opt/

### Copy bash scripts to startup notebook directory
COPY scripts/* /usr/local/bin/start-notebook.d/