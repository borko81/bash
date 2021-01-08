#/bin/bash

if [ $# -lt 1 ]
then
    echo "Input filename"
    exit 1
fi

filename=$1

if [ -f $filename ]
then
    echo "$filename exists"
fi
