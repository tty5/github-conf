#!/bin/sh
for file in $@
do
    LINENUM=`sed -n '/^#include / =' $file|sed -n '$ p'`
    if [ -z "$LINENUM" ]
    then
        LINENUM=1
    fi

    sed -i "$LINENUM a#pragma GCC optimize(\"O0\")" $file
done


#__attribute__((optimize("-O0")))
