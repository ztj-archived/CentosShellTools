#!/bin/bash

###############
### 设置代理用户
###############

echo -en ">>> Please enter the User Name address: "
read proxyuser
echo -en ">>> Please enter the User Password address: "
read proxyuserpwd
### 设置用户名和密码
id -u ${proxyuser} >/dev/null 2>&1
if [ $? -ne 0 ]; then
    useradd ${proxyuser} -s /data/shell/other/proxylogin.sh -M
    echo ${proxyuserpwd} | sudo passwd proxy --stdin  &>/dev/null
else
    echo ">>>>> Error: the username exists"
fi

