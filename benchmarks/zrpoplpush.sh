#!/usr/bin/env bash

SCRIPT_DIR=$(readlink -f $(dirname ${BASH_SOURCE[0]}))
PACKAGE_DIR=$(dirname $SCRIPT_DIR)
SRC="$PACKAGE_DIR/src/zrpoplpush.lua"

SHA=`redis-cli script load "$(cat $SRC)"`

if [ -n "$1" ]
then
    CLIENTS=$1
else
    CLIENTS=50
fi

if [ -n "$2" ]
then
    REQUESTS=$2
else
    REQUESTS=1000000
fi

redis-benchmark -c $CLIENTS -n $REQUESTS evalsha $SHA 2 queued processing