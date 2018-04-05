#!/bin/bash

### 判断判断是否存在
/data/shell/funs/yumInstallSoftware.sh wget yes
[ $? -ne 0 ] && exit 1

### 变量定义
SoftwareUrl=${1}
SoftwareName=${SoftwareUrl##*/}
SoftwarePath="/data/backups/softwares/${SoftwareName}"
SoftwareLog="/data/logs/deploy/${SoftwareName}.`date +%Y-%m-%d-%H-%M-%S`.log"

### 软件不存在时下载文件
if [ ! -f "${SoftwarePath}" ]; then
    echo ">>>>> Message: local ${SoftwareName} software does not exist, downloading ......"
    (wget -O ${SoftwarePath} ${SoftwareUrl}) &>> ${SoftwareLog}
    if [ $? -ne 0 ]; then
        echo ">>>>> Error: ${SoftwareName} downloading error"
        rm -rf ${SoftwarePath}
        exit 1
    fi
fi

exit 0
