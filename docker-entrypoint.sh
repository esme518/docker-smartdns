#!/bin/sh
set -e

if [ ! -f /smartdns/smartdns.conf ]; then
	cp /etc/smartdns/smartdns.conf /smartdns/smartdns.conf
fi

exec "$@"
