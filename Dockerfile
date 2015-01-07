FROM phusion/baseimage:0.9.8
MAINTAINER Nobuyuki Paul Aoki <aokinobu@gmail.com>

EXPOSE 8890

RUN apt-get update

#ADD 02Proxy /etc/apt/apt.conf.d/

RUN apt-get -y install dpkg-dev build-essential autoconf automake libtool flex bison gperf gawk m4 make odbcinst libxml2-dev libssl-dev libreadline-dev unzip emacs23-nox git-core openssl

RUN git clone -v https://github.com/openlink/virtuoso-opensource.git 2>&1 > /var/log/virtusos-git.log

RUN cd /virtuoso-opensource && git fetch origin

RUN cd /virtuoso-opensource && git checkout -b stable/7 origin/stable/7

RUN cd /virtuoso-opensource && ./autogen.sh
RUN cd /virtuoso-opensource && CFLAGS="-O2 -m64" && export CFLAGS && ./configure
RUN cd /virtuoso-opensource && make
RUN cd /virtuoso-opensource && make install 2>&1 > /var/log/virtusos-compile.log

RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
ADD run.sh /run.sh

RUN mkdir /virtuoso

VOLUME [/virtuoso]
CMD ["/run.sh"]
