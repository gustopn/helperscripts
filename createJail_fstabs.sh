#!/bin/sh -x

allJailsList=`grep -e '{$' /etc/jail.conf | grep -ve '^#' | awk '{ print $1 }'`

for jailsListInstance in $allJailsList
do \
  jailsInstancePath="/etc/fstab.${jailsListInstance}"
  if [ ! -e "$jailsInstancePath" ]
  then \
    echo "$jailsInstancePath"
  fi
done

