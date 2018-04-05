#!/bin/bash

sleep 5

source /data/shell/funs/loadConfigFile.sh system

for filename in ${AutoStartShell[@]}
do
    /data/shell/start/${filename}.sh
done
