#!/bin/bash

sleep 5

# 备份 gogs 数据文件
if [ -d "/data/bin/gogs/data" ]; then
    echo ">>> Backing Gogs data...."
    tar cpPfz /data/backups/codes/gogs_data.`date +%Y-%m-%d-%H-%M-%S`.tar.gz -C /data/bin/gogs/data/ "."
fi
