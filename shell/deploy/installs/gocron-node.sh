#!/bin/bash

###############
# Name: 部署安装 GoCron
# Params 1: Software Version Number
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
Version="${1}"
[ -z "${Version}" ] && Version="${GoCronVersion}"
Url="https://github.com/ouqiang/gocron/releases/download/v${Version}/gocron-node-v${Version}-linux-amd64.tar.gz"
PackagePath="/data/backups/packages/gocron-node-v${Version}-linux-amd64.tar.gz"
InstallPath="/data/bin/gocron"

### 判断软件是否已经安装
File="/data/bin/gocron/gocron-node"
[ -f "${File}" ] && echo ">>>>> Error: The software has been installed" && exit 1

### 安装前置软件

### 判断软件是否具备安装条件

### 安装软件
/data/shell/funs/wget.sh ${Url}
[ $? -ne 0 ] && exit 1
mkdir -p ${InstallPath}
tar -xf ${PackagePath} --strip-components 1 -C ${InstallPath}
chmod 755 /data/bin/gocron/gocron-node

### 验证软件安装
/data/bin/gocron/gocron-node -v > /dev/null 2>&1
[ $? -ne 0 ] && echo ">>>>> Error: software install fail" && exit 1

### 配置系统
id -u gocron > /dev/null 2>&1
[ $? -ne 0 ] && adduser gocron

### 配置软件
chown -R gocron.gocron ${InstallPath}

### 设置开机启动项

### 其他处理

exit 0
