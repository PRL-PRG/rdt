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
RUN DEBIAN_FRONTEND=noninteractive apt-get -qy install vim emacs

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

#git2r
RUN DEBIAN_FRONTEND=noninteractive apt-get -qy install libgit2-dev
#httr
RUN DEBIAN_FRONTEND=noninteractive apt-get -qy install libssl-dev
#xml2
RUN DEBIAN_FRONTEND=noninteractive apt-get -qy install libxml2-dev
#curl
RUN DEBIAN_FRONTEND=noninteractive apt-get -qy install libcurl4-openssl-dev
#rJava
RUN DEBIAN_FRONTEND=noninteractive apt-get -qy install openjdk-11-jdk default-jdk
#RMySQL
RUN DEBIAN_FRONTEND=noninteractive apt-get -qy install default-libmysqlclient-dev ##libmariadb-dev libmariadb-client-dev libmariadb-client-lgpl-dev 
#RSQLite
RUN DEBIAN_FRONTEND=noninteractive apt-get -qy install libsqlite3-dev
#odbc
RUN DEBIAN_FRONTEND=noninteractive apt-get -qy install unixodbc-dev
#rgl
RUN DEBIAN_FRONTEND=noninteractive apt-get -qy install freeglut3-dev libfreetype6-dev
# promise-dyntracing-experiment
RUN DEBIAN_FRONTEND=noninteractive apt-get -qy install xvfb parallel expect libzstd-dev
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
## promisedyntracer
################################################################################
RUN git clone --branch oopsla-2019-study-of-laziness-v1 https://github.com/aviralg/promisedyntracer.git
RUN cd promisedyntracer && make

################################################################################
## promise-dyntracing-experiment
################################################################################
RUN git clone --branch r-3.5.0 https://github.com/PRL-PRG/promise-dyntracing-experiment.git
RUN cd promise-dyntracing-experiment && make install-dependencies DEPENDENCIES_FILEPATH=scripts/package-dependencies.txt


##COPY dependencies.txt /home/tracer/dependencies.txt
##RUN Rscript -e "x <- scan('/home/tracer/dependencies.txt', character(), quote = ''); install.packages(x, Ncpus = 12, repos='http://cran.studio.com/')" > status.txt

##make: *** [Makefile:353: rJava.ts] Error 1
##make: *** [Makefile:588: RMySQL.ts] Error 1
##make: *** [Makefile:813: pkgload.ts] Error 1
##make: *** [Makefile:843: odbc.ts] Error 1
##make: *** [Makefile:953: rgl.ts] Error 1
##make: Target 'all' not remade because of errors.
##cat: XLConnectJars.out: No such file or directory
##cat: xlsxjars.out: No such file or directory
##cat: XLConnect.out: No such file or directory
##cat: xlsx.out: No such file or directory
##cat: roxygen2.out: No such file or directory
##cat: devtools.out: No such file or directory

## libgit2 openssl

## git2r fs pkgdown
## libgit2 (git2r)
## libssl-dev (httr)
## libxml2-dev (xml2)
