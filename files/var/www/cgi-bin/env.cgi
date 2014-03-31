#!/bin/bash
#
# requires:
#  bash
#  env, sort
#
cat <<_HEADER_
Content-type: text/plain

_HEADER_

/bin/env | sort
