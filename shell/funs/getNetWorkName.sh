#!/bin/bash

###############
# Name: 获取网卡名称
# author: ZhangTianJie
# email: ztj1993@gmail.com
###############

### 判断安装网络服务
nmcli -v > /dev/null 2>&1
[ $? -ne 0 ] && /data/shell/funs/yumInstallSoftware.sh NetworkManager && [ $? -ne 0 ] && exit 1

### 启动网络服务
systemctl start NetworkManager.service

### 获取活动的第一个网卡
NetWorkName1=`LANG=en && nmcli dev status | grep -m1 "ethernet  connected" | awk '{ print $1 }'`
if [ "${NetWorkName1:0:3}" == "enp" ] || [ "${NetWorkName1:0:3}" == "eth" ]; then
    echo "${NetWorkName1}" && exit 0
fi

### 获取非活动的第一个网卡
NetWorkName2=`LANG=en && nmcli dev status | grep -m1 "ethernet  disconnected" | awk '{ print $1 }'`
if [ "${NetWorkName2:0:3}" == "enp" ] || [ "${NetWorkName2:0:3}" == "eth" ]; then
    echo "${NetWorkName2}" && exit 0
fi

echo ">>>>> Error: get network name error"

exit 1
