#!/bin/bash

###############
### Docker 启动脚本
###############

sleep 5

### 引入配置文件
source /data/shell/funs/loadConfigFile.sh system

### 获取网卡名称
NetWorkName=`/data/shell/funs/getNetWorkName.sh`
[ $? -ne 0 ] && exit 1

### 添加 IP 地址
ip addr add ${IP_NETWORK%.0}.160/24 dev ${NetWorkName}
ip addr add ${IP_NETWORK%.0}.161/24 dev ${NetWorkName}
ip addr add ${IP_NETWORK%.0}.162/24 dev ${NetWorkName}
ip addr add ${IP_NETWORK%.0}.163/24 dev ${NetWorkName}
ip addr add ${IP_NETWORK%.0}.164/24 dev ${NetWorkName}
ip addr add ${IP_NETWORK%.0}.165/24 dev ${NetWorkName}
ip addr add ${IP_NETWORK%.0}.166/24 dev ${NetWorkName}
ip addr add ${IP_NETWORK%.0}.167/24 dev ${NetWorkName}
ip addr add ${IP_NETWORK%.0}.168/24 dev ${NetWorkName}
ip addr add ${IP_NETWORK%.0}.169/24 dev ${NetWorkName}

### 启用转发链
iptables -A FORWARD -s ${IP_NETMASK}/${IP_PREFIX} -j ACCEPT
iptables -A FORWARD -d ${IP_NETMASK}/${IP_PREFIX} -j ACCEPT

iptables -A FORWARD -s 172.18.0.0/16 -j ACCEPT
iptables -A FORWARD -d 172.18.0.0/16 -j ACCEPT

### 进行内网映射
#iptables -t nat -L -n --line-numbers
iptables -t nat -A PREROUTING  -i ${NetWorkName} -d ${IP_NETWORK%.0}.161 -j DNAT --to 172.18.0.1
iptables -t nat -A POSTROUTING -o ${NetWorkName} -s 172.18.0.1 -j SNAT --to ${IP_NETWORK%.0}.161

iptables -t nat -A PREROUTING  -i ${NetWorkName} -d ${IP_NETWORK%.0}.162 -j DNAT --to 172.18.0.2
iptables -t nat -A POSTROUTING -o ${NetWorkName} -s 172.18.0.2 -j SNAT --to ${IP_NETWORK%.0}.162

iptables -t nat -A PREROUTING  -i ${NetWorkName} -d ${IP_NETWORK%.0}.163 -j DNAT --to 172.18.0.3
iptables -t nat -A POSTROUTING -o ${NetWorkName} -s 172.18.0.3 -j SNAT --to ${IP_NETWORK%.0}.163

iptables -t nat -A PREROUTING  -i ${NetWorkName} -d ${IP_NETWORK%.0}.164 -j DNAT --to 172.18.0.4
iptables -t nat -A POSTROUTING -o ${NetWorkName} -s 172.18.0.4 -j SNAT --to ${IP_NETWORK%.0}.164

iptables -t nat -A PREROUTING  -i ${NetWorkName} -d ${IP_NETWORK%.0}.165 -j DNAT --to 172.18.0.5
iptables -t nat -A POSTROUTING -o ${NetWorkName} -s 172.18.0.5 -j SNAT --to ${IP_NETWORK%.0}.165

iptables -t nat -A PREROUTING  -i ${NetWorkName} -d ${IP_NETWORK%.0}.166 -j DNAT --to 172.18.0.6
iptables -t nat -A POSTROUTING -o ${NetWorkName} -s 172.18.0.6 -j SNAT --to ${IP_NETWORK%.0}.166

iptables -t nat -A PREROUTING  -i ${NetWorkName} -d ${IP_NETWORK%.0}.167 -j DNAT --to 172.18.0.7
iptables -t nat -A POSTROUTING -o ${NetWorkName} -s 172.18.0.7 -j SNAT --to ${IP_NETWORK%.0}.167

iptables -t nat -A PREROUTING  -i ${NetWorkName} -d ${IP_NETWORK%.0}.168 -j DNAT --to 172.18.0.8
iptables -t nat -A POSTROUTING -o ${NetWorkName} -s 172.18.0.8 -j SNAT --to ${IP_NETWORK%.0}.168

iptables -t nat -A PREROUTING  -i ${NetWorkName} -d ${IP_NETWORK%.0}.169 -j DNAT --to 172.18.0.9
iptables -t nat -A POSTROUTING -o ${NetWorkName} -s 172.18.0.9 -j SNAT --to ${IP_NETWORK%.0}.169
