#!/bin/sh
FCODING=$1
TCODING=$2
DIRECTORY=$3
for f in $DIRECTORY/*.txt
do
    echo "Converting $f"
    mv "$f" "$f".icv
    iconv -f $FCODING -t $TCODING "$f".icv > "$f"
    rm -f "$f".icv
done
