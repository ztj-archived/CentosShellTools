#!/bin/bash

###############
# Name: 恢复备份
# Params 1: 原始路径 <OriginalPath>(FilePath)
# Params 2: 备份路径 <TargetPath>(FilePath)
# author: ZhangTianJie
# email: ztj1993@gmail.com
###############

### 定义帮助文本
if [ "${1}" == "help" ]; then
    echo ">>> params 1 <OriginalPath>(FilePath)"
    echo ">>> params 2 <TargetPath>(FilePath)"
    exit
fi

### 设置变量
[ -z "${OriginalPath}" ] && OriginalPath="${1}"
[ -z "${OriginalName}" ] && OriginalName=`basename "${1}"`
[ -z "${TargetPath}" ] && TargetPath="${2}"

### 变量是否设置
if [ ! -n "${OriginalPath}" ]; then
    echo ">>> Error: original path does not set"
    exit 1
fi
if [ ! -n "${TargetPath}" ]; then
    TargetPath="${OriginalPath}"
else
    TargetPath="${TargetPath}/${OriginalName}"
fi

### 原始文件路径是否存在
if [ ! -f "${TargetPath}.bak" ] && [ ! -d "${TargetPath}.bak" ]; then
    echo ">>> Error: original path does not exist"
    exit 1
fi

### 恢复原始路径
\cp -fR "${TargetPath}.bak" "${OriginalPath}"

### 判断命令是否存在异常
if [ $? -ne 0 ];then
    echo ">>> Error: recovery original path fail"
    exit 1
fi
