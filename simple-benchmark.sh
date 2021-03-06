#!/bin/bash -ex
# A simple benchmark script using Apache Benmark Command

N=1000
C=10
HOST=http://localhost:8000/

while getopts "p:c:n:h:" opt; do
    case $opt in
        p)
            POST=$OPTARG
            ;;
        c)
            C=$OPTARG
            ;;
        n)
            N=$OPTARG
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

if ! test $POST; then
    POST=simple-post.txt
fi

siege -b -r $N -c $C -H "application:json" "$HOST POST <$POST"
