#!/bin/bash

###############
# Name: 初始化部署脚本
# author: ZhangTianJie
# email: ztj1993@gmail.com
###############

### 关闭 SELinux
setenforce 0 > /dev/null 2>&1
 [ -f "/etc/selinux/config" ] && sed -i "s@^SELINUX=enforcing@SELINUX=disabled@" /etc/selinux/config

### 允许数据包转发
echo 1 > /proc/sys/net/ipv4/ip_forward

### 设置目录
chown -R root.root /data/shell/
chmod -R 700 /data/shell/

### 安装软件
/data/shell/funs/yumInstallSoftware.sh wget yes
/data/shell/funs/yumInstallSoftware.sh git yes

### 设置主机名称
[ -z "${hostname}" ] && read -p ">>> Please enter the hostname: " hostname
if [ -n "${hostname}" ]; then
    hostnamectl set-hostname "${hostname}"
else
    echo ">>>>> Warning: Skipped the hostname settings"
fi

exit 0
