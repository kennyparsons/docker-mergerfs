FROM debian:buster-slim
MAINTAINER kennyparsons

ENV OPTIONS="defaults,sync_read,allow_other,category.action=all,category.create=ff"
ENV SOURCEDIRS=
ENV MOUNTPOINT="point"

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
  && rm -rf /mergerfs* /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  $$ mkdir /mnt/$MOUNTPOINT

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
