#!/bin/bash

###############
# Name: 安装 Frp
# author: ZhangTianJie
# email: ztj1993@gmail.com
###############

### 判断软件是否已经安装
[ -f "${SoftwareInstallPath}" ] && echo ">>>>> Error: ${Sign} - The software has been installed" && exit 1

### 安装前置软件

### 判断软件是否具备安装条件

### 安装软件
/data/shell/funs/wget.sh ${SoftwareUrl} ${SoftwarePackagePath} ${SoftwareName}
[ $? -ne 0 ] && echo ">>>>> Error: ${Sign} - Software download error" && exit 1

mkdir -p ${SoftwareInstallPath}
tar -xf ${SoftwarePackagePath} --strip-components 1 -C ${SoftwareInstallPath}

### 验证软件安装

### 配置系统

### 配置软件
chmod 700 /data/bin/frp/frps
chmod 700 /data/bin/frp/frpc

### 设置开机启动项
