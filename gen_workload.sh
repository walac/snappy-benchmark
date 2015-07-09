#!/bin/sh -e

LOGS_DIR=$1
WORKLOAD_DIR=workload

if ! test -d $WORKLOAD_DIR; then
    mkdir $WORKLOAD_DIR
fi

rm -f $WORKLOAD_DIR/*

cat $LOGS_DIR/* \
    | awk -F'\t' '{print $4}' \
    | grep 'Request body:' \
    | sed -e 's/Request body: //' \
    | sort \
    | uniq  \
    | awk 'BEGIN {i = 1} {print $0 > "'$WORKLOAD_DIR'/req.txt." i++}'

