#!/bin/bash

###############
# Name: 安装 Apache
# author: ZhangTianJie
# email: ztj1993@gmail.com
###############

### 引入配置文件

### 命令行参数

### 变量定义

### 判断软件是否已经安装
httpd -v > /dev/null 2>&1
[ $? -eq 0 ] && echo ">>>>> Error: The software has been installed" && exit 1


### 安装前置软件

### 判断软件是否具备安装条件

### 安装软件
/data/shell/funs/yumInstallSoftware.sh httpd
[ $? -ne 0 ] && exit 1

### 验证软件安装
httpd -v > /dev/null 2>&1
[ $? -ne 0 ] && echo ">>>>> Error: software install fail" && exit 1

### 配置系统
id -u www > /dev/null 2>&1
[ $? -ne 0 ] && useradd -M -s /sbin/nologin www

### 配置软件
[ -d /data ] && chmod 755 /data
mkdir -p /data/wwwroot
chown -R www.www /data/wwwroot
mkdir -p /data/configs/apache
chown -R www.www /data/configs/apache
# 优化配置文件
/data/shell/funs/backupPath.sh /etc/httpd/conf/httpd.conf
sed -i "s@^User apache@User www@" /etc/httpd/conf/httpd.conf
sed -i "s@^Group apache@Group www@" /etc/httpd/conf/httpd.conf
sed -i "s/^#ServerName www.example.com:80/ServerName 0.0.0.0:81/" /etc/httpd/conf/httpd.conf
sed -i "s@^Listen.*@Listen 0.0.0.0:81@" /etc/httpd/conf/httpd.conf
grep "/data/configs/apache" /etc/httpd/conf/httpd.conf > /dev/null 2>&1
[ $? -ne 0 ] && echo -e "IncludeOptional /data/configs/apache/*.conf" >> /etc/httpd/conf/httpd.conf
# 删除默认站点
rm -rf /etc/httpd/conf.d/welcome.conf

### 设置开机启动项
systemctl start httpd.service
systemctl enable httpd.service

### 其他处理

exit 0
