FROM jupyter/scipy-notebook:ubuntu-22.04

USER root

### Providing root privillages to default "jovyan" user account
RUN echo "jovyan ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER jovyan

### OS Packages installation
RUN sudo apt-get update && sudo apt-get install aptitude gdebi-core curl wget tar build-essential cmake make default-jre default-jdk cron screen pkg-config protobuf-compiler \
    libfontconfig1-dev libgsl-dev libudunits2-dev libprotobuf-dev libjq-dev libmagick++-dev gfortran fftw3 fftw3-dev libxml2-dev libcurl4-openssl-dev libfontconfig1-dev libssl-dev libsodium-dev libharfbuzz-dev libfribidi-dev libfreetype6-dev libpng-dev libtiff5-dev libjpeg-dev libgmp3-dev libmpfr-dev libarchive-dev gnupg -y

### GDAL installation
RUN sudo apt-get install libgdal-dev libproj-dev -y

### R installation - https://cran.r-project.org/bin/linux/ubuntu/#acknowledgements
RUN sudo apt install --no-install-recommends software-properties-common dirmngr -y
RUN wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
RUN sudo add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"
RUN sudo apt install --no-install-recommends r-base -y

## Use c2d4u only for IRkernel, because it didn't work on Kubernetes with install.packages.
RUN sudo add-apt-repository ppa:c2d4u.team/c2d4u4.0+
RUN sudo apt-get install r-cran-irkernel -y
## Installing R kernel to jupyterlab
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