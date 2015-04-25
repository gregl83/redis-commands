#!/usr/bin/env bash

SCRIPT_DIR=$(readlink -f $(dirname ${BASH_SOURCE[0]}))
PACKAGE_DIR=$(dirname $SCRIPT_DIR)
SRC="$PACKAGE_DIR/src/zrpoplpush.lua"

ZRPOPLPUSH=$(cat $SRC)

# todo get the benchmark script to run for src

redis-benchmark -c 50 -n 1000000 eval $($ZRPOPLPUSH) queud processing