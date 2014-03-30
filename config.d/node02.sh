#!/bin/bash
#
# requires:
#  bash
#
set -e
set -o pipefail
set -x

# Do some changes ...

# cat /etc/init.d/httpd
# cat /etc/logrotate.d/httpd

sed -i s,reload,graceful,g /etc/logrotate.d/httpd
