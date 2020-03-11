FROM debian:buster-slim
MAINTAINER kennyparsons

ENV OPTIONS=
ENV SOURCEDIRS=
ENV MOUNTPOINT=

RUN apt-get update \
  && apt-get install -y \
    git \
    make \
    fuse

RUN git clone https://github.com/trapexit/mergerfs.git \
  && cd mergerfs \
  && make install-build-pkgs \
  && make deb \
  && dpkg -i ../mergerfs_*_*.deb \
  && apt-get clean \
  && rm -rf /mergerfs* /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

VOLUME /mnt/folder1
VOLUME /mnt/folder2

CMD ["/entrypoint.sh"]