#!/bin/bash

###############
# Name: 更新部署系统
# author: ZhangTianJie
# email: ztj1993@gmail.com
###############

### 判断软件目录是否存在
if [ ! -d "/data" ]; then
    echo ">>>>> Error: the /data directory does not exist"
    exit 1
fi

### 进入目录
cd /data

### 判断仓库是否完整
git fsck > /dev/null 2>&1
[ $? -ne 0 ] && echo ">>>>> Error: The repositories does not exist" && exit 1

### 配置仓库
git config core.autocrlf false
git config core.safecrlf true
git config core.ignorecase false
git config core.filemode false

### 贮藏文件
git stash

### 获取远端
git fetch --all

### 重置 master
git reset --hard origin/master

### 清理文件
git clean -fd /data/shell

### 其他处理
chmod -R 700 /data/shell

exit 0
