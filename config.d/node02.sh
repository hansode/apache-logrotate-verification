#!/bin/bash
#
# requires:
#  bash
#
set -e
set -o pipefail
set -x

# Do some changes ...

sed -i s,reload,graceful,g /etc/logrotate.d/httpd

/usr/sbin/logrotate -f /etc/logrotate.d/httpd
