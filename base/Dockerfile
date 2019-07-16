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
##RUN DEBIAN_FRONTEND=noninteractive apt-get -qy install fish bash zsh

################################################################################
## Editor
################################################################################
##RUN DEBIAN_FRONTEND=noninteractive apt-get -qy install vim emacs

################################################################################
## Version Control
################################################################################
##RUN DEBIAN_FRONTEND=noninteractive apt-get -qy install git subversion

################################################################################
## Data Transfer
################################################################################
##RUN DEBIAN_FRONTEND=noninteractive apt-get -qy install curl wget rsync

################################################################################
## R Base
## https://cran.r-project.org/bin/linux/debian/
################################################################################
RUN DEBIAN_FRONTEND=noninteractive apt-get -qy install r-base r-base-dev

#git2r
RUN DEBIAN_FRONTEND=noninteractive apt-get -qy install libgit2-dev
#httr
RUN DEBIAN_FRONTEND=noninteractive apt-get -qy install libssl-dev
#xml2
RUN DEBIAN_FRONTEND=noninteractive apt-get -qy install libxml2-dev

RUN Rscript -e "install.packages(c('tidyverse', 'dplyr', 'devtools', 'formatR', 'remotes', 'selectr', 'caTools', 'BiocManager'))"


## libgit2 openssl

## git2r fs pkgdown
## libgit2 (git2r)
## libssl-dev (httr)
## libxml2-dev (xml2)
