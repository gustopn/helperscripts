#!/bin/sh -x
originalFilePath="$1"
if [ -n "$newBRcreationDir" ] && [ -n "$originalFilePath" ] && [ -d "$newBRcreationDir" ] && [ -f "$originalFilePath" ]
then \
  originalFileName=`echo $originalFilePath | awk -F'/' '{ print $NF }'`
  originalFileDir="${originalFilePath%/$originalFileName}"
  if [ ! -e "${newBRcreationDir}/${originalFileDir}" ]
  then \
    mkdir -p "${newBRcreationDir}/${originalFileDir}"
  fi
  workingDir=`pwd`
  if [ ! -e "${newBRcreationDir}/${originalFileDir}/${originalFileName}" ]
  then \
    ln -s "${workingDir}/${originalFileDir}/${originalFileName}" "${newBRcreationDir}/${originalFileDir}/${originalFileName}"
  fi
fi
