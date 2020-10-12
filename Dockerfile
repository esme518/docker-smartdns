#
# Dockerfile for smartdns
#

FROM alpine:latest

ARG DL_URL="https://github.com/pymumu/smartdns/releases/download/Release33/smartdns.1.2020.09.08-2235.x86_64-linux-all.tar.gz"

RUN set -ex \
    && apk --update add --no-cache \
       ca-certificates \
    && wget $DL_URL \
    && tar zxvf smartdns.*.tar.gz \
    && mv smartdns/usr/sbin/smartdns /bin/smartdns \
    && mv smartdns/etc/smartdns/smartdns.conf /etc/smartdns.conf \
    && rm -rf smartdns* \
    && rm -rf /var/cache/apk

COPY docker-entrypoint.sh /entrypoint.sh

WORKDIR /smartdns

EXPOSE 53/udp

ENTRYPOINT ["/entrypoint.sh"]
