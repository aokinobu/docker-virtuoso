FROM ubuntu:trusty
MAINTAINER Nobuyuki Paul Aoki <aokinobu@gmail.com>

RUN apt-get update

EXPOSE 8890

#ADD 02Proxy /etc/apt/apt.conf.d/

RUN apt-get -y install dpkg-dev build-essential autoconf automake libtool flex bison gperf gawk m4 make odbcinst libxml2-dev libssl-dev libreadline-dev unzip emacs23-nox git-core openssl
RUN apt-get -y install net-tools
RUN apt-get -y install procps

RUN git clone -v https://github.com/openlink/virtuoso-opensource.git 2>&1 > /var/log/virtusos-git.log
#ADD /virtuoso-opensource /virtuoso-opensource

RUN cd /virtuoso-opensource && git fetch origin

RUN cd /virtuoso-opensource && git checkout tags/v7.2.0.1
#RUN cd /virtuoso-opensource && git checkout origin/stable/7
#RUN cd /virtuoso-opensource && git checkout origin/develop/7
#RUN cd /virtuoso-opensource && git checkout tags/v7.0.0

RUN cd /virtuoso-opensource && ./autogen.sh
RUN cd /virtuoso-opensource && CFLAGS="-O2 -m64" && export CFLAGS && ./configure
RUN cd /virtuoso-opensource && make
RUN cd /virtuoso-opensource && make install 2>&1 > /var/log/virtusos-compile.log

RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
ADD run.sh /run.sh

RUN mkdir /virtuoso

RUN echo vm.swappiness=10 >> /etc/sysctl.conf

VOLUME [/virtuoso]
ENTRYPOINT /sbin/sysctl -w vm.swappiness=10; /run.sh
#CMD ["/run.sh"]
