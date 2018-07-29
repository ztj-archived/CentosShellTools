#!/bin/bash

###############
# Name: 软件 安装脚本
# author: ZhangTianJie
# email: ztj1993@gmail.com
###############

### 判断软件是否已经安装
software -v > /dev/null 2>&1
[ $? -eq 0 ] && echo ">>>>> Error: ${Sign} - The software has been installed" && exit 1

[ -d "${SoftwareInstallPath}" ] && echo ">>>>> Error: ${Sign} - The software has been installed" && exit 1

### 安装前置软件
/data/shell/funs/yumInstallSoftware.sh unzip
[ $? -ne 0 ] && echo ">>>>> Error: ${Sign} - Prefix software install error" && exit 1

### 判断软件是否具备安装条件
software -v > /dev/null 2>&1
[ $? -ne 0 ] && echo ">>>>> Error: ${Sign} - Please install the <java> first" && exit 1
[ $? -ne 0 ] && echo ">>>>> Error: ${Sign} - Do not have installation conditions" && exit 1

### 安装软件
/data/shell/funs/yumInstallSoftware.sh httpd
[ $? -ne 0 ] && echo ">>>>> Error: ${Sign} - Software install error" && exit 1

/data/shell/funs/wget.sh ${SoftwareUrl}
[ $? -ne 0 ] && echo ">>>>> Error: ${Sign} - Software download error" && exit 1

mkdir -p ${SoftwareInstallPath}
unzip ${SoftwarePackagePath} -d ${SoftwareInstallPath}
tar -xf ${PackagePath} --strip-components 1 -C ${SoftwareInstallPath}
[ $? -ne 0 ] && echo ">>>>> Error: ${Sign} - Software unzip|untar error" && exit 1

### 验证软件安装
software -v > /dev/null 2>&1
[ $? -ne 0 ] && echo ">>>>> Error: ${Sign} - Software install fail" && exit 1

### 配置系统

### 配置软件

### 设置开机启动项

### 其他处理
