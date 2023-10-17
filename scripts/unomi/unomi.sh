#!/bin/bash
log=1
if [ "$#" -eq 1 ]
then
        log="$1"
fi

name="master"
if [[ $log -eq 1 ]]
then
  echo "Checking log of master."
elif [[ $log -eq 2 ]]
then
  echo "Checking log of slaver."
  name="slaver"
else
  echo "Checking log of JS."
  name="js"
fi
filename=$(kubectl get pods --output name | grep unomi-$name | head -1)
echo $filename
sc="kubectl logs --follow $filename"
filenameMaster=$(kubectl get pods --output name | grep unomi-master | head -1)
filenameSlaver=$(kubectl get pods --output name | grep unomi-slaver | head -1)
filenameJS=$(kubectl get pods --output name | grep unomi-js | head -1)
eval "kubectl describe $filenameMaster > ~/scripts/unomi-master.desc"
eval "kubectl describe $filenameSlaver > ~/scripts/unomi-slaver.desc"
eval "kubectl describe $filenameJS > ~/scripts/unomi-js.desc"
eval $sc