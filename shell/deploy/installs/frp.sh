#!/bin/bash

###############
# Name: 安装 Frp
# author: ZhangTianJie
# email: ztj1993@gmail.com
###############

### 引入配置文件
source /data/shell/funs/loadConfigFile.sh softwares

### 命令行参数

### 变量定义
SoftwareVersion="${FrpVersion}"
SoftwareUrl="https://github.com/fatedier/frp/releases/download/v${SoftwareVersion}/frp_${SoftwareVersion}_linux_amd64.tar.gz"
SoftwareName=${SoftwareUrl##*/}
SoftwarePackagePath="/data/backups/packages/${SoftwareName}"
SoftwareInstallPath="/data/bin/frp"

### 判断软件是否已经安装
if [ -d "/data/bin/frp" ]; then
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
chmod 700 /data/bin/frp/frps
chmod 700 /data/bin/frp/frpc

### 设置开机启动项

exit 0
