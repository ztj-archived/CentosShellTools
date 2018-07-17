#!/bin/bash

###############
# Name: 安装 Gogs
# author: ZhangTianJie
# email: ztj1993@gmail.com
###############

### 引入配置文件
source /data/shell/funs/loadConfigFile.sh softwares

### 命令行参数

### 变量定义
SoftwareUrl="https://dl.gogs.io/${GogsVersion}/linux_amd64.tar.gz"
SoftwareName=${SoftwareUrl##*/}
SoftwarePackagePath="/data/backups/packages/${SoftwareName}"
SoftwareInstallPath="/data/bin/gogs"
SoftwareConfigPath=""

### 判断软件是否已经安装
if [ -f "${SoftwareInstallPath}/gogs" ]; then
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
id -u git > /dev/null 2>&1
[ $? -ne 0 ] && adduser git

### 配置软件
chown -R git.git ${SoftwareInstallPath}

### 设置开机启动项

### 其他处理

exit 0
