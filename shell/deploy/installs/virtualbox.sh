#!/bin/bash

###############
# Name: VirtualBox 联网部署
# author: ZhangTianJie
# email: ztj1993@gmail.com
###############

### 引入配置文件

### 命令行参数

### 变量定义

### 判断软件是否已经安装
VBoxManage -v > /dev/null 2>&1
[ $? -eq 0 ] && echo ">>>>> Error: The software has been installed" && exit 1

### 安装前置软件
rm -rf /etc/yum.repos.d/virtualbox.repo
/data/shell/funs/wget.sh https://download.virtualbox.org/virtualbox/rpm/el/virtualbox.repo
[ $? -ne 0 ] && exit 1
cp -rf /data/backups/packages/virtualbox.repo /etc/yum.repos.d/virtualbox.repo

/data/shell/funs/yumInstallSoftware.sh gcc
[ $? -ne 0 ] && exit 1
/data/shell/funs/yumInstallSoftware.sh make
[ $? -ne 0 ] && exit 1
/data/shell/funs/yumInstallSoftware.sh kernel
[ $? -ne 0 ] && exit 1
/data/shell/funs/yumInstallSoftware.sh kernel-devel
[ $? -ne 0 ] && exit 1

### 判断软件是否具备安装条件

### 安装软件
/data/shell/funs/yumInstallSoftware.sh VirtualBox-5.2
[ $? -ne 0 ] && echo ">>>>> Error: software install error" && exit 1

### 验证软件安装
VBoxManage -v > /dev/null 2>&1
[ $? -ne 0 ] && echo ">>>>> Error: software install fail" && exit 1

### 配置系统

### 配置软件

### 设置开机启动项

### 其他处理
rm -rf /etc/yum.repos.d/virtualbox.repo

exit 0
