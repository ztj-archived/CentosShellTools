#!/bin/bash

###############
# Name: 部署安装 模板文件
# Params 1: Software Version Number
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
Version="${1}"
[ -z "${Version}" ] && Version="${Version}"

### 判断软件是否已经安装
software -v > /dev/null 2>&1
[ $? -eq 0 ] && echo ">>>>> Error: The software has been installed" && exit 1

### 安装前置软件
/data/shell/funs/yumInstallSoftware.sh java
[ $? -ne 0 ] && echo ">>>>> Error: Prefix software install error" && exit 1

### 判断软件是否具备安装条件
software -v > /dev/null 2>&1
[ $? -ne 0 ] && echo ">>>>> Error: please install the <java> first" && exit 1
[ $? -ne 0 ] && echo ">>>>> Error: Do not have installation conditions" && exit 1

### 安装软件

### 验证软件安装
software -v > /dev/null 2>&1
[ $? -ne 0 ] && echo ">>>>> Error: software install fail" && exit 1

### 配置系统

### 配置软件

### 设置开机启动项

### 其他处理

exit 0
