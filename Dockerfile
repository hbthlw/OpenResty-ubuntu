FROM ubuntu:16.04

RUN groupadd --gid 1000 resty \
  && useradd --uid 1000 --gid resty --shell /bin/bash --create-home resty

RUN apt-get -y update && apt-get install -y \
  libreadline-dev \
  libncurses5-dev \
  libpcre3-dev \
  libssl-dev \
  perl \
  make \
  build-essential \
  curl

ENV RESTY_VERSION 1.11.2.3

RUN curl -O https://openresty.org/download/openresty-${RESTY_VERSION}.tar.gz 
RUN curl -O https://openresty.org/download/openresty-${RESTY_VERSION}.tar.gz.asc

COPY ./A0E98066.key .
RUN gpg --import A0E98066.key
RUN gpg --verify openresty-${RESTY_VERSION}.tar.gz.asc openresty-${RESTY_VERSION}.tar.gz

RUN tar -xvf openresty-${RESTY_VERSION}.tar.gz
WORKDIR openresty-${RESTY_VERSION}
RUN ./configure
RUN make
RUN make install

ENV PATH /usr/local/openresty/nginx/sbin:$PATH
RUN echo $PATH

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
VOLUME ["/usr/src/app"]

EXPOSE 80

STOPSIGNAL SIGTERM

CMD ["nginx", "-p", "/usr/src/app/", "-c", "conf/nginx.conf", "-g", "daemon off;"]

