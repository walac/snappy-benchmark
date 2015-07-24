#!/bin/bash -ex
# A simple benchmark script using Apache Benmark Command

N=1000
C=10
HOST=http://localhost:8000/
URLS_TXT=urls.txt

while getopts "u:c:n:" opt; do
    case $opt in
        u)
            URLS_TXT=$OPTARG
            ;;
        c)
            C=$OPTARG
            ;;
        n)
            N=$OPTARG
            ;;
        \?)
            exit 1
            ;;
        :)
            exit 1
            ;;
    esac
done

siege -i -q -b -r $N -c $C -f $URLS_TXT -H "application:json"

