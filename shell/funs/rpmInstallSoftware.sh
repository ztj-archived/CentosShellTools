#!/bin/bash

### 变量定义
SoftwareName=${1}
SoftwareUrl=${2}
SoftwarePath="/data/backups/packages/${SoftwareName}.rpm"
SoftwareLog="/data/logs/deploy/${SoftwareName}.`date +%Y-%m-%d-%H-%M-%S`.log"

### 软件已经安装
if [ -n "`rpm -qa | grep -F ${SoftwareName}`" ]; then
    echo ">>>>> Warning: ${SoftwareName} has been installed"
    exit 0
fi

### 软件安装文件不存在时下载文件
if [ ! -f "${SoftwarePath}" ]; then
    echo ">>>>> Message: local ${SoftwareName} software does not exist, downloading ......"
    (wget -O ${SoftwarePath} ${SoftwareUrl}) &>> ${SoftwareLog}
    if [ $? -ne 0 ]; then
        echo ">>>>> Error: ${SoftwareName} downloading error"
        rm -rf ${SoftwarePath}
        exit 1
    fi
fi

### 安装软件
(rpm -Uvh ${SoftwarePath} --nodeps --force) &>> ${SoftwareLog}
if [ $? -ne 0 ]; then
    echo ">>>>> Error: ${SoftwareName} install error"
    exit 1
fi
exit 0
