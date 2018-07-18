#!/bin/bash

###############
# Name: SSH 执行文件
# Params 1: <Host>(Host|IP) 主机节点
# Params 2: <Username>(Username) 用户名
# Params 3: <Password>(Password) 密码
# Params 4: <Files>(ShellFiles) 脚本文件，多个文件以空格分割
# author: ZhangTianJie
# email: ztj1993@gmail.com
###############

### 定义帮助文本
if [ "${1}" == "help" ]; then
    echo ">>> params 1 <Host>(Host|IP)"
    echo ">>> params 2 <Username>(Username)"
    echo ">>> params 3 <Password>(Password)"
    echo ">>> params 4 <Files>(ShellFiles)"
    exit
fi

### 设置变量
[ -z "${Host}" ] && Host="${1}"
[ -z "${Username}" ] && Username="${2}"
[ -z "${Password}" ] && Password="${3}"
[ -z "${Files}" ] && Files=(${4})

### 执行文件
cat ${Files[*]} | sshpass -p "${Password}" ssh -T -o StrictHostKeyChecking=no ${Username}@${Host}
