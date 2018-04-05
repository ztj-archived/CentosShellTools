#!/bin/bash

###############
# Name: 初始化 iptables
# author: ZhangTianJie
# email: ztj1993@gmail.com
###############

### 引入配置文件
source /data/shell/funs/loadConfigFile.sh system

### 安装软件
/data/shell/funs/yumInstallSoftware.sh iptables
/data/shell/funs/yumInstallSoftware.sh iptables-services

### 禁用 firewalld
firewalld -h  > /dev/null 2>&1 && systemctl stop firewalld && systemctl mask firewalld

### 启动 iptables
systemctl start iptables

### 获取网卡名称
NetWorkName=`/data/shell/funs/getNetWorkName.sh`
[ $? -ne 0 ] && exit 1

### 清空已有的规则
iptables -F
iptables -X
iptables -Z
iptables -t nat -F
iptables -t nat -X

### 允许本机lo通信
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

### 开放指定端口
for port in ${FirewallOpenPort[@]}
do
    iptables -A INPUT -p tcp --dport ${port} -j ACCEPT
done

### 开放指定地址
for source in ${FirewallOpenSource[@]}
do
    iptables -A INPUT -p tcp -s ${source} -j ACCEPT
done

### 设置默认的访问规则
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

iptables -A FORWARD -i ${NetWorkName} -j ACCEPT
iptables -A FORWARD -o ${NetWorkName} -j ACCEPT

iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT

### 保存配置
service iptables save

### 重启服务
systemctl restart iptables.service
systemctl enable iptables.service
