#!/bin/bash

###############
# Name: GoCronNode service management
# Params 1: start|stop|restart
# author: ZhangTianJie
# email: ztj1993@gmail.com
###############

### 定义脚本名称
ServiceName="GoCronNode"
ServiceBin="/data/bin/gocron/gocron-node"
ServiceUser="gocron"

source /data/shell/service/.Common.sh
