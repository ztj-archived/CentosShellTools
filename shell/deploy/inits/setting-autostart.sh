#!/bin/bash

###############
# Name: 设置开机自动启动
# author: ZhangTianJie
# email: ztj1993@gmail.com
###############

StartShellPath="/data/shell/start/auto.sh"
StartShellLogPath="/data/logs/start/auto_\`date +%Y-%m-%d-%H-%M-%S\`.log"

 ### 判断启动脚本是否存在
if [ ! -f "${StartShellPath}" ]; then
    echo ">>>>> Error: the var <StartShellPath> does not exist"
    exit 1
fi

### 判断启动设置文件是否存在
if [ ! -f "/etc/rc.d/rc.local" ]; then
    echo ">>>>> Error: the file </etc/rc.d/rc.local> does not exist"
    exit 1
fi

### 判断是否已经设置过了
grep "${StartShellPath}" /etc/rc.d/rc.local > /dev/null
if [ $? -eq 0 ]; then
    echo ">>>>> Error: Configuration already exists"
    exit 1
fi

### 设置启动脚本
chmod +x /etc/rc.d/rc.local
echo -e "\nnohup ${StartShellPath} &> ${StartShellLogPath} &\n" >> /etc/rc.d/rc.local

exit 0