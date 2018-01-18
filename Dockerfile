#
# Dockerfile for cpuminer
# usage: docker run creack/cpuminer --url xxxx --user xxxx --pass xxxx
# ex: docker run creack/cpuminer --url stratum+tcp://ltc.pool.com:80 --user creack.worker1 --pass abcdef
#
#

FROM  ubuntu:14.04
RUN apt-get update && apt-get install -y \ 
  autoconf \
  automake \
  libtool \
  wget \
  unzip \
  build-essential \
  libncurses5-dev \
  libcurl4-openssl-dev
RUN apt-get clean
RUN cd /; \
wget -O cgminer.zip https://codeload.github.com/ckolivas/cgminer/zip/v2.11.4 && unzip cgminer.zip; \
  cd /cgminer-2.11.4; \
  ./autogen.sh; \
  ./configure --enable-cpumining --disable-opencl; \
  make; \
  make install;
ADD ./init.sh /init.sh
CMD ["/init.sh"]
