#!/bin/sh -x
brdevice=`lsscsi  | grep BD-RE | grep -oE '/dev/sr[0-9]'`
isoFile="$1"
if [ -f "$isoFile" ]
then \
  if [ -b "$brdevice" ]
  then \
    cdrskin -v -dao fs=512M dev="$brdevice" "$isoFile"
    eject "$brdevice"
    sleep 3
    eject -t "$brdevice"
  fi
fi
