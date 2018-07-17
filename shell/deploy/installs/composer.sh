#!/bin/bash

###############
# Name: 安装 Composer
# author: ZhangTianJie
# email: ztj1993@gmail.com
###############

### 引入配置文件

### 命令行参数

### 变量定义
SoftwareUrl="https://getcomposer.org/composer.phar"
SoftwareName="composer.phar"
SoftwarePackagePath="/data/backups/packages/${SoftwareName}"
SoftwareInstallPath="/usr/local/bin/composer"

### 判断软件是否已经安装
if [ -f "/usr/local/bin/composer" ]; then
    echo ">>>>> Error: the software has been installed"
    exit 1
fi

### 安装前置软件

### 判断软件是否具备安装条件
php -v > /dev/null 2>&1
[ $? -ne 0 ] && echo ">>>>> Error: please install the <php> first" && exit 1


### 安装软件
/data/shell/funs/wget.sh ${SoftwareUrl}
[ $? -ne 0 ] && exit 1
cp ${SoftwarePackagePath} ${SoftwareInstallPath} && chmod 755 ${SoftwareInstallPath}

### 验证软件安装
composer -V > /dev/null 2>&1
[ $? -ne 0 ] && echo ">>>>> Error: software install fail" && exit 1

### 配置系统

### 配置软件
composer config -g secure-http false

### 设置开机启动项

### 其他处理

exit 0
