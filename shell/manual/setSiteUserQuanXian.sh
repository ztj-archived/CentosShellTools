#!/bin/bash

#
# 一键权限设置
#

if [ "${1}" == "" ]; then
    echo ">>>>> Error: 请输入要设置的目录"
    exit
fi

dirpath="${1}"

if [ -z "${dirpath}" ]; then
    echo ">>>>> Error: 请直接在脚本后面传递要设置权限的目录路径，相对于 /data/wwwroot/ 路径"
    exit
elif [ ! -d "${dirpath}" ]; then
    echo ">>>>> Error: 您输入的路径不存在，请检查"
    exit
fi

chown -R www.www "${dirpath}"
find "${dirpath}" -type d -exec chmod 755 {} \;
find "${dirpath}" -type f -exec chmod 644 {} \;

echo ">>>>> Success: 已完成目录权限设置"