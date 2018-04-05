#!/bin/bash

###############
# Name: 部署 phpMyAdmin
# Params 1: Software Version Number
# Params 2: <SoftwareDir>(DirPath)
# author: ZhangTianJie
# email: ztj1993@gmail.com
###############

### 引入配置文件
source /data/shell/funs/loadConfigFile.sh softwares

### 命令行参数
if [ "${1}" == "help" ]; then
    echo ">>> Params 1 <SoftwareVersion>(VersionNumber)"
    echo ">>> Params 2 <SoftwareDir>(DirPath)"
    exit
fi

### 变量定义
SoftwareVersion=${1}
SoftwareDir=${2}

[ "${SoftwareVersion}" == "" ] && SoftwareVersion="${phpMyAdminVersion}"
[ "${SoftwareDir}" == "" ] && SoftwareDir="${phpMyAdminDir}"

SoftwareUrl="https://files.phpmyadmin.net/phpMyAdmin/${SoftwareVersion}/phpMyAdmin-${SoftwareVersion}-all-languages.tar.gz"
SoftwareName=${SoftwareUrl##*/}
SoftwarePackagePath="/data/backups/softwares/${SoftwareName}"
SoftwareInstallPath="/data/wwwroot/default/${SoftwareDir}"

### 判断软件是否已经安装

### 安装前置软件

### 判断软件是否具备安装条件

### 安装软件
/data/shell/funs/wget.sh ${SoftwareUrl}
[ $? -ne 0 ] && exit 1
rm -rf ${SoftwareInstallPath}
mkdir -p ${SoftwareInstallPath}
tar -xf ${SoftwarePackagePath} --strip-components 1 -C ${SoftwareInstallPath}
chown -R www.www ${SoftwareInstallPath}
[ $? -ne 0 ] && exit 1

### 验证软件安装

### 配置系统

### 配置软件
sed -i "s@^\$cfg\['LoginCookieValidity'\].*@\$cfg['LoginCookieValidity'] = 144000;@" ${SoftwareInstallPath}/libraries/config.default.php

### 设置开机启动项

### 其他处理

exit 0