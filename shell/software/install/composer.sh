#!/bin/bash

###############
# Name: 安装 Composer
# author: ZhangTianJie
# email: ztj1993@gmail.com
###############

### 判断软件是否已经安装
[ -d "${SoftwareInstallPath}" ] && echo ">>>>> Error: ${Sign} - The software has been installed" && exit 1

### 安装前置软件

### 判断软件是否具备安装条件
php -v > /dev/null 2>&1
[ $? -ne 0 ] && echo ">>>>> Error: ${Sign} - Please install the <php> first" && exit 1

### 安装软件
/data/shell/funs/wget.sh ${SoftwareUrl}
[ $? -ne 0 ] && echo ">>>>> Error: ${Sign} - Software download error" && exit 1
cp ${SoftwarePackagePath} ${SoftwareInstallPath} && chmod 755 ${SoftwareInstallPath}

### 验证软件安装
composer -V > /dev/null 2>&1
[ $? -ne 0 ] && echo ">>>>> Error: ${Sign} - Software install fail" && exit 1

### 配置系统

### 配置软件
composer config -g secure-http false

### 设置开机启动项

### 其他处理
