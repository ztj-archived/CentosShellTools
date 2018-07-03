#!/bin/bash

###############
# Name: 数据库压缩备份
# author: ZhangTianJie
# email: ztj1993@gmail.com
###############

### 定义帮助文本
if [ "${1}" == "help" ] || [ "${1}" == "" ]; then
    echo ">>> params 1 <DbName|All>"
    echo ">>> params 2 <SavePath>(DirPath)"
    exit
fi

### 设置变量
DbName="${1}"
SavePath="${2}"

### 判断变量
if [ "${DbName}" == "" ]; then
    echo ">>>>> Error: the var <DbName> does not exist"
    exit 0
fi
if [ "${SavePath}" == "" ]; then
    echo ">>>>> Error: the var <SavePath> does not exist"
    exit 0
fi

#获取当前系统时间
datetime=`date +%Y-%m-%d-%H-%M-%S`

#引入数据库配置文件
source /data/shell/funs/loadConfigFile.sh mysql

#备份数据库
if [ "${DbName}" == "All" ]; then
    mysqldump --host="${db_host}" --port="${db_port}" \
        --user="${db_root_user}" --password="${db_root_pass}" \
        --all-databases | gzip > "${SavePath}/${DbName}.${datetime}.sql.gz"
else
    mysqldump --host="${db_host}" --port="${db_port}" \
        --user="${db_root_user}" --password="${db_root_pass}" \
        "${DbName}" | gzip > "${SavePath}/${DbName}.${datetime}.sql.gz"
fi
