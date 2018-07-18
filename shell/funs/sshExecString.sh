#!/bin/bash

###############
# Name: SSH 执行字符串
# Params 1: <Host>(Host|IP) 主机节点
# Params 2: <Username>(Username) 用户名
# Params 3: <Password>(Password) 密码
# Params 4: <String>(ShellString) 脚本字符串
# author: ZhangTianJie
# email: ztj1993@gmail.com
###############

### 定义帮助文本
if [ "${1}" == "help" ]; then
    echo ">>> params 1 <Host>(Host|IP)"
    echo ">>> params 2 <Username>(Username)"
    echo ">>> params 3 <Password>(Password)"
    echo ">>> params 4 <String>(ShellString)"
    exit
fi

### 设置变量
[ -z "${Host}" ] && Host="${1}"
[ -z "${Username}" ] && Username="${2}"
[ -z "${Password}" ] && Password="${3}"
[ -z "${String}" ] && String="${4}"

### 执行字符串
sshpass -p "${Password}" ssh -o StrictHostKeyChecking=no ${Username}@${Host} "${String}"
