#!/bin/bash

###############
# Name: 恢复备份
# Params 1: <SoftwareUrl>(Url) 软件地址
# Params 2: <SoftwarePath>(FilePath) 软件本地路径
# Params 2: <SoftwareName>(FileName) 软件名称
# author: ZhangTianJie
# email: ztj1993@gmail.com
###############

### 定义帮助文本
if [ "${1}" == "help" ]; then
    echo ">>> params 1 <SoftwareUrl>(Url)"
    echo ">>> params 2 <SoftwarePath>(FilePath)"
    echo ">>> params 3 <SoftwareName>(FileName)"
    exit
fi

### 判断判断是否存在
wget  -V > /dev/null 2>&1
[ $? -ne 0 ] && echo ">>>>> Error: Please install wget first" && exit 1

### 变量定义
[ -z "${SoftwareUrl}" ] && SoftwareUrl=${1}
[ -z "${SoftwarePath}" ] && SoftwarePath=${2}
[ -z "${SoftwareName}" ] && SoftwareName=${3}

[ -z "${SoftwareName}" ] && SoftwareName=${SoftwareUrl##*/}
[ -z "${SoftwarePath}" ] && SoftwarePath=/data/backups/packages/${SoftwareName}

mkdir -p /data/logs/wget
SoftwareLog="/data/logs/wget/${SoftwareName}.`date +%Y-%m-%d-%H-%M-%S`.log"

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
