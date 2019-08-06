#!/bin/bash

file=$1
target_deps=$2

TMP=$(mktemp)

/usr/bin/time -o $TMP -f command:%C:costtime:%e bash "${@:3}"

flock -x $1 echo pwd:`pwd`:$target_deps:`cat $TMP` >> $1

rm $TMP

exit 0
