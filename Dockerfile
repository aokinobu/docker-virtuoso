FROM debian:jessie
MAINTAINER Nobuyuki Paul Aoki <aokinobu@gmail.com>

RUN apt-get update

EXPOSE 8890

#RUN echo "Acquire::http { Proxy \"http://test.glytoucan.org:3142\"; };" > /etc/apt/apt.conf.d/02Proxy

RUN apt-get -y install dpkg-dev build-essential autoconf automake libtool flex bison gperf gawk m4 make odbcinst libxml2-dev libssl-dev libreadline-dev unzip git-core openssl
RUN apt-get -y install net-tools
RUN apt-get -y install procps

RUN git clone -v https://github.com/openlink/virtuoso-opensource.git 2>&1 > /var/log/virtusos-git.log
#ADD /virtuoso-opensource /virtuoso-opensource

RUN cd /virtuoso-opensource && git fetch origin

#https://github.com/openlink/virtuoso-opensource/blob/stable/7/NEWS
#https://github.com/openlink/virtuoso-opensource/issues/251
RUN cd /virtuoso-opensource && git checkout tags/v7.2.4.2
#RUN cd /virtuoso-opensource && git checkout tags/v7.2.2.1
#RUN cd /virtuoso-opensource && git checkout tags/v7.2.0.1
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
RUN chmod a+x /run.sh

RUN mkdir /virtuoso

RUN echo vm.swappiness=10 >> /etc/sysctl.conf

ADD scripts /scripts
VOLUME [/virtuoso]
#ENTRYPOINT /sbin/sysctl -w vm.swappiness=10; /run.sh
CMD ["/run.sh"]
