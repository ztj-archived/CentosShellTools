#!/bin/bash

###############
# Name: 通过 yum 安装指定软件
# Params 1: SoftwareName
# Params 2: IsTips
# author: ZhangTianJie
# email: ztj1993@gmail.com
###############

### 变量定义
[ -z "${SoftwareName}" ] && SoftwareName=${1}
[ -z "${IsTips}" ] && IsTips=${2}
SoftwarePath="/data/backups/packages/${SoftwareName}"
SoftwareLog="/data/logs/deploy/${SoftwareName}.`date +%Y-%m-%d-%H-%M-%S`.log"

### 处理变量
[ -n "${GlobalIsTips}" ] && IsTips=${GlobalIsTips}

### 软件已经安装
if [ -n "`yum list installed | grep -F ${SoftwareName}.`" ]; then
    echo ">>>>> Warning: ${SoftwareName} has been installed"
    exit 0
fi

### 安装提示
if [ "${IsTips}" == "yes" ]; then
    read -p ">>> Whether to install software ${SoftwareName} (y): " IsTips
    if [ "${IsTips}" != "y" ]; then
        echo ">>>>> Warning: Skipped the ${SoftwareName} installation"
        exit 1
    fi
fi

### 软件安装目录不存在时创建目录并下载包
if [ ! -d "${SoftwarePath}" ]; then
    echo ">>>>> Message: local ${SoftwareName} software does not exist, downloading ......"
    mkdir -p ${SoftwarePath}
    yum install ${SoftwareName} --downloadonly --downloaddir=${SoftwarePath} &>> ${SoftwareLog}
    if [ $? -ne 0 ]; then
        echo ">>>>> Error: ${SoftwareName} downloading error"
        rm -rf ${SoftwarePath}
        exit 1
    fi
fi
rpm -Uvh ${SoftwarePath}/*.rpm --nodeps --force &>> ${SoftwareLog}
if [ $? -ne 0 ]; then
    echo ">>>>> Error: ${SoftwareName} install error"
    exit 1
fi

echo ">>>>> Message: ${SoftwareName} installation success"

exit 0
