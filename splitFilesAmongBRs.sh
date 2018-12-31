#!/bin/sh -x
singleSideBRbytesize=`echo "((10^3)^3)*25" | bc`
leftOverSpace="$singleSideBRbytesize"
brDiscCount=1
scriptDir=`dirname $0`

echo $scriptDir