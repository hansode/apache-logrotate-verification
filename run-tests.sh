#!/bin/bash
#
# requires:
#  bash
#

set -e
set -o pipefail

nodes="
 node01
 node02
"

for i in ${nodes}; do
  echo === ${i} ===
  vagrant ssh ${i} -c '/vagrant/logrotate-test.sh'
done

echo "All test passed!!!"
