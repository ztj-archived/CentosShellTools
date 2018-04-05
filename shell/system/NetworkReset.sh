#!/bin/bash

### 获取网卡名称
NetWorkName=`/data/shell/funs/getNetWorkName.sh`
[ $? -ne 0 ] && exit 1

### 禁用与启用指定网卡
ifdown "${NetWorkName}"
sleep 5
ifup "${NetWorkName}"

### 重启网络服务
sleep 5
systemctl restart network.service
