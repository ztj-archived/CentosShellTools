#!/bin/bash

###############
### 设置 IP
###############

echo -en ">>> Please enter the IP address:"
read staticip
echo -en ">>> Please enter the GATEWAY address:"
read gateway
echo -en ">>> Please enter the NETMASK address:"
read netmask
echo -en ">>> Please enter the DNS1 address:"
read dns1
echo -en ">>> Please enter the DNS2 address:"
read dns2

if [ ! -n "${staticip}" ] || [ ! -n "${gateway}" ] || [ ! -n "${netmask}" ]; then
    echo ">>>>> Error: params error"
fi

#### 获取网卡的设备与配置文件
NetWorkName=`/data/shell/funs/getNetWorkName.sh`
NetworkConfigFile="/etc/sysconfig/network-scripts/ifcfg-${NetWorkName}"

#### 判断配置文件是否存在
if [ ! -f "${NetworkConfigFile}" ]; then
    echo ">>>>> Error: network config file does not exist"
    exit
fi

### 备份配置文件与还原默认配置文件
/data/shell/funs/backupPath.sh "${NetworkConfigFile}"
/data/shell/funs/recoveryOriginalPath.sh "${NetworkConfigFile}"

### 注释原有的配置
sed -i "s@^BOOTPROTO=@# BOOTPROTO=@" ${NetworkConfigFile}
sed -i "s@^ONBOOT=@# ONBOOT=@" ${NetworkConfigFile}
sed -i "s@^IPADDR=@# IPADDR=@" ${NetworkConfigFile}
sed -i "s@^GATEWAY=@# GATEWAY=@" ${NetworkConfigFile}
sed -i "s@^NETMASK=@# NETMASK=@" ${NetworkConfigFile}
sed -i "s@^DNS1=@# DNS1=@" ${NetworkConfigFile}
sed -i "s@^DNS2=@# DNS2=@" ${NetworkConfigFile}

### 配置 IP 地址
echo -e "\n" >> ${NetworkConfigFile}
echo -e "BOOTPROTO=static" >> ${NetworkConfigFile}
echo -e "ONBOOT=yes" >> ${NetworkConfigFile}
echo -e "IPADDR=${staticip}" >> ${NetworkConfigFile}
echo -e "GATEWAY=${gateway}" >> ${NetworkConfigFile}
echo -e "NETMASK=${netmask}" >>${NetworkConfigFile}
echo -e "DNS1=${dns1}" >>${NetworkConfigFile}
echo -e "DNS2=${dns2}" >>${NetworkConfigFile}
