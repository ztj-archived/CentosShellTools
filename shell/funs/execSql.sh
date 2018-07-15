#!/bin/bash

###############
# Name: 执行 SQL 语句
# Params 1: sql
# author: ZhangTianJie
# email: ztj1993@gmail.com
###############

### 定义变量
[ -z "${Sql}" ] && Sql="${1}"

### 判断变量
if [ ! -n "${Sql}" ]; then
    echo ">>> Error: param <SQL(1)> does not set"
    exit 1
fi

### 生成导入的语句文件
tmpfile=`mktemp /tmp/sql.XXX`
echo "${Sql}"> ${tmpfile}

### 执行语句
source /data/shell/funs/loadConfigFile.sh mysql
mysql --host=${db_host} --port=${db_port} --user=${db_root_user} --password=${db_root_pass} < ${tmpfile}
[ $? -ne 0 ] && echo ">>>>> Error: exec sql error" && exit 1

### 删除语句文件
rm -rf ${tmpfile}
