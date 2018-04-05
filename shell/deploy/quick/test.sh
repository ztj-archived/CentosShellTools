#!/bin/bash

###############
# Name: 测试环境 (注意本脚本会一键安装所有软件)
# author: ZhangTianJie
# email: ztj1993@gmail.com
###############

### 判断软件目录是否存在
if [ -d "/data" ]; then
    echo ">>>>> Error: the /data directory already exists"
    exit 1
fi

### 更新系统
/data/shell/deploy/quick/update.sh

### 初始化部署
/data/shell/deploy/inits/init.sh
/data/shell/deploy/inits/update-system.sh
/data/shell/deploy/inits/setting-autostart.sh
/data/shell/deploy/inits/iptables.sh

### Lnamp部署
/data/shell/deploy/installs/nginx.sh
/data/shell/deploy/installs/apache.sh
/data/shell/deploy/installs/mysql57.sh
/data/shell/deploy/installs/php71.sh
/data/shell/deploy/installs/phpmyadmin.sh
/data/shell/deploy/installs/composer.sh

### Docker 部署
/data/shell/deploy/installs/docker.sh

### Elasticsearch 部署
/data/shell/deploy/installs/elasticsearch.sh
/data/shell/deploy/installs/kibana.sh
/data/shell/deploy/installs/go-mysql-elasticsearch.sh

### Gogs 部署
/data/shell/deploy/installs/gogs.sh

### JcsegServer 部署
/data/shell/deploy/installs/jcsegserver.sh

### Frp 部署
/data/shell/deploy/installs/frp.sh

exit 0
