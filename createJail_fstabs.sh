#!/bin/sh -x

jailsDirPrefixPath="/jail"
allJailsList=`grep -e '{$' /etc/jail.conf | grep -ve '^#' | awk '{ print $1 }'`

if [ ! -d "$jailsDirPrefixPath" ]
then \
  exit 1
fi

for jailsListInstance in $allJailsList
do \
  jailsInstanceFstabPath="/etc/fstab.${jailsListInstance}"
  jailsInstanceRoot="${jailsDirPrefixPath}/${jailsListInstance}"
  if [ ! -e "$jailsInstanceFstabPath" ]
  then \
    touch "$jailsInstanceFstabPath"
  fi
  if [ -d "$jailsInstanceRoot" ]
  then \
    if [ ! -e "${jailsInstanceRoot}/usr/ports" ]
    then \
      mkdir "${jailsInstanceRoot}/usr/ports"
    fi
    if [ -d "${jailsInstanceRoot}/usr/ports" ] && [ -d "/usr/ports" ]
    then \
      echo "/usr/ports ${jailsInstanceRoot}/usr/ports nullfs ro 0 0" >> "$jailsInstanceFstabPath"
    fi
  fi
done

