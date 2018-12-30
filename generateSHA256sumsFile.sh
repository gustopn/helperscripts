#!/bin/sh -x
sumsfile="sha256sums.txt"
find . -xdev -type f -and -not -name "$sumsfile" | xargs -d"\n" sha256sum > "$sumsfile"