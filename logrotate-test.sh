#!/bin/bash
#
# requires:
#  bash
#
set -e
set -o pipefail

LANG=C

## 0: dummy http requests

for i in {1..3}; do
  echo ... "${i} GET /cgi-bin/env.cgi"
  curl -fsSkL http://localhost/cgi-bin/env.cgi >/dev/null
done

## 1: keep http-connection

curl -fsSkL http://localhost/cgi-bin/sleep.cgi &
pid=$!

ps -p ${pid}
sleep 3

## 2: show logrotate config

echo logrotate ....
cat  /etc/logrotate.d/httpd

## 3: force-rotate

sudo /usr/sbin/logrotate -f /etc/logrotate.d/httpd

## 4: list log files

sudo ls -la /var/log/httpd/
sleep 3

## 5: verify

svccmd=$(egrep "/sbin/service httpd" /etc/logrotate.d/httpd | awk '{print $3}')

echo kill ${pid}

case "${svccmd}" in
  reload)
    ! kill ${pid}
    ;;
  gracefull)
      kill ${pid}
    ;;
esac

##

echo "=> OK"
