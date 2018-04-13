#!/bin/bash

###############
# Name: 安装 Nodejs
# author: ZhangTianJie
# email: ztj1993@gmail.com
###############

### 引入配置文件
source /data/shell/funs/loadConfigFile.sh softwares

### 命令行参数
if [ "${1}" == "help" ]; then
    echo ">>>>> params 1: SoftwareVersion"
    exit
fi

### 变量定义
SoftwareVersion="${1}"
[ -z "${SoftwareVersion}" ] && SoftwareVersion="${NodejsVersion}"
SoftwareUrl="https://npm.taobao.org/mirrors/node/v${SoftwareVersion}/node-v${SoftwareVersion}-linux-x64.tar.gz"
SoftwareName=${SoftwareUrl##*/}
SoftwarePackagePath="/data/backups/softwares/${SoftwareName}"
SoftwareInstallPath="/data/bin/nodejs"

### 判断软件是否已经安装
if [ -f "${SoftwareInstallPath}/bin/node" ]; then
    echo ">>>>> Error: the software has been installed"
    exit 1
fi

### 安装前置软件

### 判断软件是否具备安装条件

### 安装软件
/data/shell/funs/wget.sh ${SoftwareUrl}
[ $? -ne 0 ] && exit 1
mkdir -p ${SoftwareInstallPath}
tar -xf ${SoftwarePackagePath} --strip-components 1 -C ${SoftwareInstallPath}

### 验证软件安装

### 配置系统

### 配置软件

### 设置开机启动项

### 其他处理

exit 0
