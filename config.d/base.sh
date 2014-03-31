#!/bin/bash
#
# requires:
#  bash
#
set -e
set -o pipefail
set -x

# Do some changes ...

/etc/init.d/httpd start

if [[ -d /vagrant ]]; then
  rsync -avx /vagrant/files/var/www/cgi-bin/ /var/www/cgi-bin/
fi

# install /etc/logrotate.d/httpd

cat <<EOS | tee /etc/logrotate.d/httpd
/var/log/httpd/*log {
   #weekly
    rotate 5
    missingok
    compress
    delaycompress
    sharedscripts
    postrotate
        /sbin/service httpd reload > /dev/null 2>/dev/null || true
    endscript
}
EOS
