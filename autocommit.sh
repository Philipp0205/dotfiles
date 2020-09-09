#!/bin/bash

path=$1 

CURRENTDATE=`date +"%Y-%m-%d %T"`
DATETIME=`date +"%Y-%m-%d %T"`

echo "path " $path

cd $path

while true 
do 
  git pull 
  git add -A 
  git commit -m "${DATETIME}"
  git push origin master
  sleep 300
done
  					

