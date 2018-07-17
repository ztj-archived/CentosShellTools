#!/bin/bash

###############
# Name: 恢复备份
# Params 1: <OriginalPath>(FilePath|DirPath|Required) 原始路径
# Params 2: <TargetPath>(DirPath) 目标路径
# Params 2: <PathAlias>(FileName|DirName) 路径别名
# author: ZhangTianJie
# email: ztj1993@gmail.com
###############

### 定义帮助文本
if [ "${1}" == "help" ]; then
    echo ">>> params 1 <OriginalPath>(FilePath|DirPath|Required)"
    echo ">>> params 2 <TargetPath>(DirPath)"
    echo ">>> params 2 <PathAlias>(FileName|DirName)"
    exit
fi

### 设置变量
[ -z "${OriginalPath}" ] && OriginalPath="${1}"
[ -z "${TargetPath}" ] && TargetPath="${2}"
[ -z "${PathAlias}" ] && PathAlias="${3}"

### 处理变量
[ -z "${TargetPath}" ] && TargetPath=$(dirname "${OriginalPath}")
[ -z "${PathAlias}" ] && PathAlias=$(basename "${OriginalPath}")

### 判断变量
if [ ! -f "${TargetPath}/${PathAlias}.bak" ] && [ ! -d "${TargetPath}/${PathAlias}.bak" ]; then
    echo ">>>>> Error: Backup does not exist"
    exit 1
fi

### 备份现在的原始路径
if [ -f "${OriginalPath}" ] || [ -d "${OriginalPath}" ]; then
    source /data/shell/funs/pathBackup.sh
fi

### 删除原始文件
rm -rf "${OriginalPath}"

### 恢复原始路径
\cp -fR "${TargetPath}/${PathAlias}.bak" "${OriginalPath}"
[ $? -ne 0 ] && echo ">>>>> Error: recovery path failed" && exit 1
