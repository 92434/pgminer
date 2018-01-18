#
# Dockerfile for cpuminer
# usage: docker run creack/cpuminer --url xxxx --user xxxx --pass xxxx
# ex: docker run creack/cpuminer --url stratum+tcp://ltc.pool.com:80 --user creack.worker1 --pass abcdef
#
#

FROM            ubuntu:14.04
MAINTAINER      Guillaume J. Charmes <guillaume@charmes.net>

RUN             apt-get update -qq

RUN             apt-get install -qqy autoconf automake libtool wget
RUN             apt-get install -qqy build-essential libncurses5-dev libcurl4-openssl-dev
RUN             apt-get clean

RUN             wget -O cgminer.zip https://codeload.github.com/ckolivas/cgminer/zip/v2.11.4
RUN             unzip cgminer.zip
RUN             cd cgminer-2.11.4 && \
                chmod +x autogen.sh && \
                ./autogen.sh && \
                ./configure --enable-cpumining --disable-opencl && \
                make

WORKDIR        ~/cgminer-2.11.4
ENTRYPOINT      ["./cgminer"]
