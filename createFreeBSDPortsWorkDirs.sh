#!/bin/sh -x

createPortsWorkDirs() {

  altRootPrefix="$1"
  if [ -n "${altRootPrefix}" ]
  then \
    if [ ! -d "${altRootPrefix}" ]
    then \
      return 1
    fi
  fi

  workDirPrefixPath="/usr/work"
  workDirLocalPortsbuildPath="${workDirPrefixPath}/local"
  workDirLocalDistfilesPath="${workDirPrefixPath}/distfiles"
  workDirLocalPackagesPath="${workDirPrefixPath}/packages"

  makeConfPath="/etc/make.conf"

  for workDirInstances in "$workDirLocalPortsbuildPath" "$workDirLocalDistfilesPath" "$workDirLocalPackagesPath"
  do \
    if [ ! -e "${altRootPrefix}${workDirInstances}" ]
    then \
      mkdir -p "${altRootPrefix}${workDirInstances}"
    fi
  done

  cp "${altRootPrefix}${makeConfPath}" "${altRootPrefix}${makeConfPath}.old" && grep -v "WRKDIRPREFIX=" "${altRootPrefix}${makeConfPath}.old" | grep -v "DISTDIR=" | grep -v "PACKAGES=" > "${altRootPrefix}${makeConfPath}"
  echo "WRKDIRPREFIX=${workDirLocalPortsbuildPath}" >> "${altRootPrefix}${makeConfPath}"
  echo "DISTDIR=${workDirLocalDistfilesPath}" >> "${altRootPrefix}${makeConfPath}"
  echo "PACKAGES=${workDirLocalPackagesPath}" >> "${altRootPrefix}${makeConfPath}"

}

if [ "$#" -eq 0 ]
then \
  createPortsWorkDirs
else \
  while [ "$#" -gt 0 ]
  do \
    createPortsWorkDirs $1
    shift
  done
fi