#
# Dockerfile for smartdns
#

FROM alpine as source

ARG URL=https://api.github.com/repos/pymumu/smartdns/releases/latest

WORKDIR /root

RUN set -ex \
    && apk add --update --no-cache curl \
    && wget -O smartdns $(curl -s $URL | grep browser_download_url | egrep -o "https.+\-$(uname -m)") \
    && wget https://raw.githubusercontent.com/pymumu/smartdns/master/etc/smartdns/smartdns.conf \
    && chmod +x smartdns

FROM alpine
COPY --from=source /root/smartdns /usr/local/bin/smartdns
COPY --from=source /root/smartdns.conf /etc/smartdns/smartdns.conf

COPY docker-entrypoint.sh /entrypoint.sh

RUN set -ex \
    && apk --update add --no-cache \
       ca-certificates \
    && rm -rf /tmp/* /var/cache/apk/*

WORKDIR /smartdns

EXPOSE 53/udp

ENTRYPOINT ["/entrypoint.sh"]
CMD ["smartdns","-f","-x","-c","/smartdns/smartdns.conf"]
