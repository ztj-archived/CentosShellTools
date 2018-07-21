#!/bin/bash

###############
# Name: 部署 Elasticsearch
# author: ZhangTianJie
# email: ztj1993@gmail.com
###############

### 引入配置文件
source /data/shell/funs/loadConfigFile.sh softwares

### 命令行参数
if [ "${1}" == "help" ]; then
    echo ">>>>> params 1: SoftwareVersion"
    exit
fi

### 变量定义
SoftwareVersion="${1}"
[ -z "${SoftwareVersion}" ] && SoftwareVersion="${ElasticsearchVersion}"
rpmSoftwareUrl="https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${SoftwareVersion}.rpm"
rpmSoftwareName="elasticsearch-${SoftwareVersion}"

### 判断软件是否已经安装
systemctl status elasticsearch.service > /dev/null 2>&1
[ $? -eq 0 ] && echo ">>>>> Error: The software has been installed" && exit 1

### 安装前置软件
/data/shell/funs/yumInstallSoftware.sh java
[ $? -ne 0 ] && exit 1

### 判断软件是否具备安装条件

### 安装软件
/data/shell/funs/rpmInstallSoftware.sh "${rpmSoftwareName}" "${rpmSoftwareUrl}"
[ $? -ne 0 ] && exit 1

systemctl status elasticsearch.service > /dev/null 2>&1
[ $? -ne 0 ] && echo ">>>>> Error: software install fail" && exit 1

### 配置系统
sysctl -w vm.max_map_count=262144
/data/shell/funs/pathBackup.sh /etc/sysctl.conf
echo "vm.max_map_count=262144" >> /etc/sysctl.conf
/data/shell/funs/pathBackup.sh /etc/security/limits.conf
echo "elasticsearch hard nofile 65536" >> /etc/security/limits.conf
echo "elasticsearch soft nofile 65536" >> /etc/security/limits.conf

### 配置软件
/data/shell/funs/pathBackup.sh /etc/elasticsearch/elasticsearch.yml
echo "network.host: 0.0.0.0" >> /etc/elasticsearch/elasticsearch.yml

### 设置开机启动项
systemctl start elasticsearch.service
systemctl enable elasticsearch.service

exit 0
