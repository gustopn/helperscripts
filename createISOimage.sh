#!/bin/sh -x
isoSourceDir="${1%/}"
isoImageOutputDir="/fast/ISO"
if [ -d "${isoSourceDir}" ]
then \
  if [ -f "${isoSourceDir}/sha256sums.txt" ]
  then \
    genisoimage -allow-limited-size -f -input-charset "UTF-8" -iso-level 3 -J -joliet-long -r -udf -V "${isoSourceDir}" -v -o "${isoImageOutputDir}/${isoSourceDir}.iso" "${isoSourceDir}/"
  else \
    echo "forgot to create SHA256 sums?"
  fi
fi