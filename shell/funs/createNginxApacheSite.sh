#!/bin/bash

###############
### 创建 Nginx Apache 类型站点
###############

### 定义变量
SiteSign="${1}"
SiteRootPath="${2}"
ServerName="${3}"
ServerAlias="${4}"
MainDomain="${5}"

### 判断变量
if [ ! -n "${SiteSign}" ]; then
    echo ">>>>> Error: param <SiteSign(1)> does not set"
    exit 1
fi
if [ ! -n "${SiteRootPath}" ]; then
    echo ">>>>> Error: param <SiteRootPath(2)> does not set"
    exit 1
fi
if [ ! -n "${ServerName}" ]; then
    echo ">>>>> Error: param <ServerName(3)> does not set"
    exit 1
fi

### 配置系统
id -u www > /dev/null 2>&1
[ $? -ne 0 ] && useradd -M -s /sbin/nologin www

### 创建目录
mkdir -p ${SiteRootPath}
chown -R www.www ${SiteRootPath}

### 定义 Nginx 配置文件
NginxConfigPath="/data/configs/nginx/vhost_${SiteSign}.conf"
cat > ${NginxConfigPath} << EOF
server {
    server_name ${ServerName} ${ServerAlias};
    root ${SiteRootPath};
    include /data/configs/nginx/vhost_apache.conf.public;
}
EOF
chown -R www.www ${NginxConfigPath}

### 定义 Apache 配置文件
ApacheConfigPath="/data/configs/apache/vhost_${SiteSign}.conf"
cat > ${ApacheConfigPath} << EOF
<VirtualHost *:81>
    DocumentRoot "${SiteRootPath}"
    ServerName ${ServerName}
    ServerAlias ${ServerAlias}
    <Directory "${SiteRootPath}">
        SetOutputFilter DEFLATE
        Options FollowSymLinks ExecCGI
        Require all granted
        AllowOverride All
        Order allow,deny
        Allow from all
        DirectoryIndex index.html index.php
    </Directory>
</VirtualHost>
EOF
chown -R www.www ${ApacheConfigPath}

### 处理 ServerAlias 为空的情况
[ ! -n "${ServerAlias}" ] && sed -i "/ServerAlias/d" ${ApacheConfigPath}

### 设置域名跳转
MainDomainStr="    if (\$host != ${MainDomain}) {return 301 \$scheme://${MainDomain}\$request_uri; }"
[ -n "${MainDomain}" ] && sed -i -e "s@^    root.*;@&\n${MainDomainStr}@" ${NginxConfigPath}

nginx -v > /dev/null 2>&1
[ $? -eq 0 ] && systemctl restart nginx.service
httpd -v > /dev/null 2>&1
[ $? -eq 0 ] && systemctl restart httpd.service

exit 0
