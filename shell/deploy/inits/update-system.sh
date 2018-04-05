#!/bin/bash

###############
# Name: 更新系统
# author: ZhangTianJie
# email: ztj1993@gmail.com
###############

SoftwarePath="/data/backups/softwares/updates-system"
SoftwareLog="/data/logs/deploy/updates-system.`date +%Y-%m-%d-%H-%M-%S`.log"

### 判断本地路径是否存在并下载
if [ ! -d "${SoftwarePath}" ]; then
    echo ">>>>> Warning: local software does not exist, downloading ......"
    (
        yum clean all &&
        yum makecache &&
        yum update --downloadonly --downloaddir=${SoftwarePath}
    ) &>> ${SoftwareLog}
    if [ $? -ne 0 ]; then
        echo ">>>>> Error: software downloading error"
        rm -rf ${SoftwarePath}
        exit 1
    fi
fi

### 执行安装
rpm -Uvh ${SoftwarePath}/*.rpm --nodeps --force &>> ${SoftwareLog}
if [ $? -ne 0 ]; then
    echo ">>>>> Error: software install error"
    exit 1
fi

exit 0