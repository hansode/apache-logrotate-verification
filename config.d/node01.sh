#!/bin/bash
#
# requires:
#  bash
#
set -e
set -o pipefail
set -x

# Do some changes ...

/usr/sbin/logrotate -f /etc/logrotate.d/httpd
