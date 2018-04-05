#!/bin/bash

sleep 5

# 启动 gogs
if [ -f "/data/bin/gogs/gogs" ] && [ -f "/data/bin/gogs/custom/conf/app.ini" ]; then
    echo ">>> Starting Gogs service...."
    /data/shell/service/Gogs.sh start
fi

# 启动 frp 服务端
if [ -f "/data/bin/frp/frps" ] && [ -f "/data/configs/frp/frps.ini" ]; then
    echo ">>> Starting Frps service...."
    /data/shell/service/Frps.sh start
fi

# 启动 frp 客户端
if [ -f "/data/bin/frp/frpc" ] && [ -f "/data/configs/frp/frpc.ini" ]; then
    echo ">>> Starting Frpc service...."
    /data/shell/service/Frpc.sh start
fi
