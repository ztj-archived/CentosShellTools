#!/bin/bash

###############
# Name: 路径备份
# Params 1: 原路径 <OriginalPath>(FilePath)
# Params 2: 目标路径 <TargetPath>(FilePath)
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

### 判断目标路径是否存在
if [ ! -f "${OriginalPath}" ] && [ ! -d "${OriginalPath}" ]; then
    echo ">>>>> Warning: original path does not exist"
    exit 0
fi

### 设置目标路径
if [ ! -n "${TargetPath}" ]; then
    TargetPath="${OriginalPath}"
else
    TargetPath="${TargetPath}/${OriginalName}"
fi

### 备份原始文件
if [ ! -f "${TargetPath}.bak" ] && [ ! -d "${TargetPath}.bak" ]; then
    cp -fR "${OriginalPath}" "${TargetPath}.bak"
fi

### 按日期备份
DateTime=`date +%Y-%m-%d-%H-%M-%S`
cp -fR "${OriginalPath}" "${TargetPath}.bak.${DateTime}"
[ $? -ne 0 ] && echo ">>>>> Error: backup path error" && exit 1

exit 0
