#!/bin/bash

###############
# Name: 安装 kibana
# Params 1: Software Version Number)
# author: ZhangTianJie
# email: ztj1993@gmail.com
###############

### 引入配置文件
source /data/shell/funs/loadConfigFile.sh softwares

### 命令行参数
if [ "${1}" == "help" ] || [ "${1}" == "" ]; then
    echo ">>> Params 1 <SoftwareVersion>(VersionNumber)"
    exit
fi

### 变量定义
SoftwareVersion="${1}"
[ -z "${SoftwareVersion}" ] && SoftwareVersion="${KibanaVersion}"
rpmSoftwareUrl="https://artifacts.elastic.co/downloads/kibana/kibana-${SoftwareVersion}-x86_64.rpm"
rpmSoftwareName="kibana-${SoftwareVersion}-1.x86_64"

### 判断软件是否已经安装
systemctl status kibana.service > /dev/null 2>&1
[ $? -eq 0 ] && echo ">>>>> Error: The software has been installed" && exit 1

### 安装前置软件
/data/shell/funs/yumInstallSoftware.sh java
[ $? -ne 0 ] && echo ">>>>> Error: please install the <java> first" && exit 1

### 判断软件是否具备安装条件
systemctl status elasticsearch.service > /dev/null 2>&1
[ $? -ne 0 ] && echo ">>>>> Error: Do not have installation conditions" && exit 1

### 安装软件
/data/shell/funs/rpmInstallSoftware.sh "${rpmSoftwareName}" "${rpmSoftwareUrl}"
[ $? -ne 0 ] && exit 1

### 验证软件安装

### 配置系统

### 配置软件
/data/shell/funs/backupPath.sh /etc/kibana/kibana.yml
echo "server.host: 0.0.0.0" >> /etc/kibana/kibana.yml

### 设置开机启动项
systemctl start kibana.service
systemctl enable kibana.service

### 其他处理

exit 0
