# docker build -t rocker440 --progress=plain . > >(stdbuf -oL tee docker_build_output.log) 2> >(stdbuf -oL tee -a docker_build_output.log)
# docker run --name cg -p 8787:8787 --rm -ti -e PASSWORD=1234 rocker440
FROM rocker/rstudio:4.4.0

### Providing root privillages to default "rstudio" user account
RUN sudo usermod -aG sudo rstudio

### OS Packages installation
RUN sudo apt-get update && sudo apt-get install aptitude gdebi-core curl wget tar build-essential cmake make default-jre default-jdk cron screen pkg-config protobuf-compiler libfontconfig1-dev libgsl-dev libudunits2-dev libprotobuf-dev libjq-dev libmagick++-dev gfortran fftw3 fftw3-dev libxml2-dev libcurl4-openssl-dev libfontconfig1-dev libssl-dev libsodium-dev libharfbuzz-dev libfribidi-dev libfreetype6-dev libpng-dev libtiff5-dev libjpeg-dev libgmp3-dev libmpfr-dev libarchive-dev gnupg libmysqlclient-dev -y

### GDAL installation
# RUN sudo add-apt-repository ppa:ubuntugis/ubuntugis-unstable # Not necessary
RUN sudo apt-get update && sudo apt-get install libgdal-dev libgeos-dev libproj-dev -y

### gsutil installation
RUN sudo echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add - && sudo apt-get update -y && sudo apt-get install google-cloud-cli -y

### NCO installation
RUN sudo aptitude install nco -y

### CROP models installation
## DSSAT installation
RUN sudo mkdir -p /opt/DSSAT/v4.7.5.30 && \
    sudo chown -R rstudio:users /opt/DSSAT/v4.7.5.30/.

RUN sudo mkdir -p /opt/DSSAT/v4.8.1.40 && \
    sudo chown -R rstudio:users /opt/DSSAT/v4.8.1.40/.

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
RUN chown -R rstudio:rstudio /opt/DSSAT/v4.7.5.30/*

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
RUN chown -R rstudio:rstudio /opt/DSSAT/v4.8.1.40/*

## ApsimX
RUN sudo apt-get update && sudo apt-get install libsqlite3-dev dotnet-sdk-6.0 -y

RUN cd /opt/ && \
    sudo git clone https://github.com/APSIMInitiative/ApsimX && \
    sudo chown -R rstudio:users /opt/ApsimX/. && \
    dotnet build -c Release ./ApsimX/ApsimX.sln

## rJava dependencies
RUN sudo R CMD javareconf

### R packages installation
COPY packages.R packages.R
RUN sudo Rscript packages.R
RUN rm packages.R
