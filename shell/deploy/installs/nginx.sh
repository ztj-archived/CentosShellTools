#!/bin/bash

###############
# Name: 安装 Nginx
# author: ZhangTianJie
# email: ztj1993@gmail.com
###############

### 引入配置文件

### 命令行参数

### 变量定义
rpmSoftwareUrl="http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm"
rpmSoftwareName=$(basename ${rpmSoftwareUrl} .rpm)

### 判断软件是否已经安装
nginx -v > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo ">>>>> Error: the software has been installed"
    exit 1
fi

### 安装前置软件
/data/shell/funs/rpmInstallSoftware.sh ${rpmSoftwareName} ${rpmSoftwareUrl}
[ $? -ne 0 ] && exit 1

### 判断软件是否具备安装条件

### 安装软件
/data/shell/funs/yumInstallSoftware.sh nginx
[ $? -ne 0 ] && exit 1

### 验证软件安装

### 配置系统
id -u www >/dev/null 2>&1
[ $? -ne 0 ] && useradd -M -s /sbin/nologin www

### 配置软件
[ -d /data ] && chmod 755 /data
mkdir -p /data/wwwroot
chown -R www.www /data/wwwroot
mkdir -p /data/configs/nginx
chown -R www.www /data/configs/nginx

/data/shell/funs/backupPath.sh /etc/nginx/nginx.conf
sed -i "s@^user.*@user www;@" /etc/nginx/nginx.conf
grep "/data/configs/nginx" /etc/nginx/conf.d/default.conf > /dev/null
[ $? -ne 0 ] && echo -e "include /data/configs/nginx/*.conf;" > /etc/nginx/conf.d/default.conf

### 设置开机启动项
systemctl start nginx.service
systemctl enable nginx.service

### 其他处理
yum remove ${rpmSoftwareName} -y &>> /dev/null

exit 0
