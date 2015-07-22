#!/bin/sh -e
# Generate the workload from snappy logs
# Build the siege urls.txt file

LOGS_DIR=logs
HOST=http://localhost:8000/
WORKLOAD_DIR=workload

while getopts "l:h:" opt; do
    case $opt in
        l)
            LOGS_DIR=$OPTARG
            ;;
        h)
            HOST=$OPTARG
            ;;
        \?)
            exit 1
            ;;
        :)
            exit 1
            ;;
    esac
done

if ! test -d $WORKLOAD_DIR; then
    mkdir $WORKLOAD_DIR
fi

rm -f $WORKLOAD_DIR/*

zcat $LOGS_DIR/* \
    | awk -F'\t' '{print $4}' \
    | grep 'Request body:' \
    | sed -e 's/Request body: //' \
    | sort \
    | uniq  \
    | awk 'BEGIN {i = 1} {print $0 > "'$WORKLOAD_DIR'/post.txt." i++}'

ls -1 $WORKLOAD_DIR/post.txt* | awk '{print "'$HOST' POST <"$0}' > urls.txt

