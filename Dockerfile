################################################################################
## https://hub.docker.com/_/debian/
################################################################################
FROM debian:buster

################################################################################
## Upgrade
################################################################################
RUN apt-get update
RUN apt-get -y dist-upgrade

################################################################################
## Miscellaneous
################################################################################
RUN DEBIAN_FRONTEND=noninteractive apt-get -qy install sudo apt-utils

################################################################################
## Locale
## https://hub.docker.com/_/debian/
## https://github.com/docker-library/postgres/blob/69bc540ecfffecce72d49fa7e4a46680350037f9/9.6/Dockerfile#L21-L24
## http://jaredmarkell.com/docker-and-locales/
################################################################################
RUN DEBIAN_FRONTEND=noninteractive apt-get -qy install locales
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
RUN locale-gen en_US.UTF-8
RUN /usr/sbin/update-locale LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

################################################################################
## Shell
################################################################################
RUN DEBIAN_FRONTEND=noninteractive apt-get -qy install fish bash zsh

################################################################################
## Editor
################################################################################
RUN DEBIAN_FRONTEND=noninteractive apt-get -qy install vim emacs-nox

################################################################################
## Version Control
################################################################################
RUN DEBIAN_FRONTEND=noninteractive apt-get -qy install git subversion

################################################################################
## Data Transfer
################################################################################
RUN DEBIAN_FRONTEND=noninteractive apt-get -qy install curl wget rsync

################################################################################
## R Base
## https://cran.r-project.org/bin/linux/debian/
################################################################################
RUN DEBIAN_FRONTEND=noninteractive apt-get -qy install r-base r-base-dev

################################################################################
## Rcheckserver
## https://github.com/jeroen/rcheckserver/blob/master/debian/Dockerfile#L18
################################################################################
RUN DEBIAN_FRONTEND=noninteractive apt-get -qy install debian-keyring
RUN gpg --recv-keys 3B1C3B572302BCB1
RUN gpg --armor --export 3B1C3B572302BCB1 | apt-key add -
RUN echo "deb http://statmath.wu.ac.at/AASC/debian testing main non-free" > /etc/apt/sources.list.d/rcheckserver.list
RUN apt-get -y update
RUN DEBIAN_FRONTEND=noninteractive apt-get -yq install rcheckserver

################################################################################
## User
################################################################################
RUN useradd -ms /bin/bash -G sudo tracer
USER tracer
WORKDIR /home/tracer
RUN mkdir -p /home/tracer/library
ENV R_LIBS_USER /home/tracer/library
ENV R_KEEP_PKG_SOURCE 1
ENV R_ENABLE_JIT 0
ENV R_COMPILE_PKGS 0
ENV R_DISABLE_BYTECODE 1
ENV OMP_NUM_THREADS 1

################################################################################
## R-dyntrace
################################################################################
RUN git clone --branch r-3.5.0 https://github.com/PRL-PRG/R-dyntrace.git
RUN cd R-dyntrace && ./build

################################################################################
## BiocManager
################################################################################
RUN git clone https://github.com/Bioconductor/BiocManager.git
RUN R-dyntrace/bin/R CMD INSTALL BiocManager

################################################################################
## BioConductor Mirror
## https://bioconductor.org/about/mirrors/mirror-how-to/
################################################################################
RUN mkdir -p /home/tracer/mirrors/bioconductor/3.9
RUN ln -s /home/tracer/mirrors/bioconductor/3.9 /home/tracer/mirrors/bioconductor/release
RUN rsync -zrtlv --delete \
  --include '/bioc/' \
  --include '/bioc/REPOSITORY' \
  --include '/bioc/SYMBOLS' \
  --include '/bioc/VIEWS' \
  --include '/bioc/src/' \
  --include '/bioc/src/contrib/' \
  --include '/bioc/src/contrib/**' \
  --exclude '/bioc/src/contrib/Archive/**' \
  --include '/data/' \
  --include '/data/experiment/' \
  --include '/bioc/experiment/REPOSITORY' \
  --include '/bioc/experiment/SYMBOLS' \
  --include '/bioc/experiment/VIEWS' \
  --include '/data/experiment/src/' \
  --include '/data/experiment/src/contrib/' \
  --include '/data/experiment/src/contrib/**' \
  --exclude '/data/experiment/src/contrib/Archive/**' \
  --include '/data/annotation/' \
  --include '/bioc/annotation/REPOSITORY' \
  --include '/bioc/annotation/SYMBOLS' \
  --include '/bioc/annotation/VIEWS' \
  --include '/data/annotation/src/' \
  --include '/data/annotation/src/contrib/' \
  --include '/data/annotation/src/contrib/**' \
  --exclude '/data/annotation/src/contrib/Archive/**' \
  --include '/workflows/' \
  --include '/workflows/REPOSITORY' \
  --include '/workflows/SYMBOLS' \
  --include '/workflows/VIEWS' \
  --include '/workflows/src/' \
  --include '/workflows/src/contrib/' \
  --include '/workflows/src/contrib/**' \
  --exclude '/workflows/src/contrib/Archive/**' \
  --exclude '/**' \
  master.bioconductor.org::release /home/tracer/mirrors/bioconductor/release

################################################################################
## CRAN Mirror
## https://cran.r-project.org/mirror-howto.html
################################################################################
RUN mkdir -p /home/tracer/mirrors/cran
RUN rsync -zrtlv --delete \
  --include '/src' \
  --include '/src/contrib' \
  --include '/src/contrib/*.tar.gz' \
  --include '/src/contrib/Symlink' \
  --include '/src/contrib/Symlink/**' \
  --exclude '**' \
  cran.r-project.org::CRAN /home/tracer/mirrors/cran

################################################################################
## Install all R packages
################################################################################
RUN DEBIAN_FRONTEND=noninteractive apt-get -qy install nproc
COPY install-packages.R ~/
R-dyntrace/bin/R --file=install-packages.R

################################################################################
## Metadata
################################################################################
LABEL maintainer "goel.aviral@gmail.com"
LABEL description "RDT Docker Image"

CMD ["bash"]
