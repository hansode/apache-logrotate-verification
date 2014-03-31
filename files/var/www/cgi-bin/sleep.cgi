#!/bin/bash
#
# requires:
#  bash
#  env, sort
#
cat <<_HEADER_
Content-type: text/plain

_HEADER_

sleep_time=300

date

echo ... sleep:${sleep_time}
sleep ${sleep_time}

date
