#!/bin/sh -x

workDirPrefixPath="/usr/work"
workDirLocalPortsbuildPath="${workDirPrefixPath}/local"
workDirLocalDistfilesPath="${workDirPrefixPath}/distfiles"
workDirLocalPackagesPath="${workDirPrefixPath}/packages"

for workDirInstances in "$workDirLocalPortsbuildPath" "$workDirLocalDistfilesPath" "$workDirLocalPackagesPath"
do \
  if [ ! -e "${workDirInstances}" ]
  then \
    mkdir -p "${workDirInstances}"
  fi
done

cp /etc/make.conf /etc/make.conf.old && grep -v "WRKDIRPREFIX=" /etc/make.conf.old | grep -v "DISTDIR=" | grep -v "PACKAGES=" > /etc/make.conf
echo "WRKDIRPREFIX=${workDirLocalPortsbuildPath}" >> /etc/make.conf
echo "DISTDIR=${workDirLocalDistfilesPath}" >> /etc/make.conf
echo "PACKAGES=${workDirLocalPackagesPath}" >> /etc/make.conf
