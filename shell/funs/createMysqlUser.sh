#!/bin/bash

###############
# Name: 创建 MySQL 用户
# Params 1: 用户名称
# Params 2: 用户密码
# Params 3: 数据库主机
# author: ZhangTianJie
# email: ztj1993@gmail.com
###############

### 定义帮助文本
if [ "${1}" == "help" ]; then
    echo ">>> params 1 <DbUserName>(String)"
    echo ">>> params 2 <DbUserPwd>(String)"
    echo ">>> params 3 <DbUserHost>(String)"
    exit
fi

### 定义变量
[ -z "${DbUserName}" ] && DbUserName="${1}"
[ -z "${DbUserPwd}" ] && DbUserPwd="${2}"
[ -z "${DbUserHost}" ] && DbUserHost="${3}"

### 判断变量
if [ ! -n "${DbUserName}" ]; then
    echo ">>>>> Error: param <DbUserName(1)> does not set"
    exit 1
fi
if [ ! -n "${DbUserPwd}" ]; then
    echo ">>>>> Error: param <DbUserPwd(2)> does not set"
    exit 1
fi
if [ ! -n "${DbUserHost}" ]; then
    echo ">>>>> Error: param <DbUserHost(3)> does not set"
    exit 1
fi

### 生成SQL语句
sql="
CREATE USER IF NOT EXISTS '${DbUserName}'@'${DbUserHost}' IDENTIFIED BY '${DbUserPwd}';
CREATE DATABASE IF NOT EXISTS ${DbUserName};
GRANT ALL PRIVILEGES ON \`${DbUserName}\`.* TO '${DbUserName}'@'${DbUserHost}';
GRANT ALL PRIVILEGES ON \`${DbUserName}\_%\`.* TO '${DbUserName}'@'${DbUserHost}';
"

### 执行语句
/data/shell/funs/execSql.sh "${sql}"
[ $? -ne 0 ] && exit 1

exit 0
