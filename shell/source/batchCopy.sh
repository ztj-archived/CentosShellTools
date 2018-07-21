#!/bin/bash

###############
# Name: 批量复制
# Params 1: <BatchCopyPaths>(ArrayString) 复制的路径
# author: ZhangTianJie
# email: ztj1993@gmail.com
###############

### 定义帮助文本
if [ "${1}" == "help" ] || [ "${1}" == "" ]; then
    echo ">>> params 1 <BatchCopyPaths>(ArrayString)[OriginalPath=>TargetPath]"
    exit
fi

### 设置变量
[ -z "${BatchCopyPaths}" ] && BatchCopyPaths=(${*})

### 判断是否定义了路径
if [ "${BatchCopyPaths[*]}" == "" ]; then
    echo ">>>>> Error: the var <BatchCopyPaths>(ArrayString) does not exist"
    exit 1
fi

### 循环数组
for Path in ${BatchCopyPaths[@]}
do
    ### 复制文件
    \cp -fR ${Path%=>*} ${Path#*=>}
    [ $? -ne 0 ] && echo ">>>>> Error: copy path error" && exit 1
done
