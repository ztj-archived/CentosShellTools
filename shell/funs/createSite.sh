#!/bin/bash

###############
# Name: 创建站点
# author: ZhangTianJie
# email: ztj1993@gmail.com
###############

### 定义帮助文本
if [ "${1}" == "help" ] || [ "${1}" == "" ]; then
    echo ">>> params 1 <SiteSign>"
    echo ">>> params 2 <SiteRootPath>"
    echo ">>> params 3 <ServerName>"
    echo ">>> params 4 <ServerAlias>"
    echo ">>> params 5 <MainDomain>"
    echo ">>> params 6 <SslSign>"
    exit
fi

### 定义变量
[ -z "${SiteSign}" ] && SiteSign="${1}"
[ -z "${SiteRootPath}" ] && SiteRootPath="${2}"
[ -z "${ServerName}" ] && ServerName="${3}"
[ -z "${ServerAlias}" ] && ServerAlias="${4}"
[ -z "${MainDomain}" ] && MainDomain="${5}"
[ -z "${SslSign}" ] && SslSign="${6}"

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

### 定义配置文件数组
declare -A SiteConfigs
SiteConfigs=(
    ["SiteSign"]="${SiteSign}"
    ["SiteRootPath"]="${SiteRootPath}"
    ["ServerName"]="${ServerName}"
    ["ServerAlias"]="${ServerAlias}"
    ["MainDomain"]="${MainDomain}"
    ["SslSign"]="${SslSign}"
)

### 配置系统
id -u www > /dev/null 2>&1
[ $? -ne 0 ] && useradd -M -s /sbin/nologin www

### 创建目录
mkdir -p ${SiteRootPath}
chown -R www.www ${SiteRootPath}

### 定义 Nginx 配置文件
if [ -n "${SslSign}" ]; then
    ExampleFile="/data/configs/nginx/vhost_ssl_apache.example"
else
    ExampleFile="/data/configs/nginx/vhost_apache.example"
fi
ConfigFile="/data/configs/nginx/vhost_apache_${SiteSign}.conf"
\cp -fR "${ExampleFile}" "${ConfigFile}"
for var in ${!SiteConfigs[@]}
do
   sed -i "s@\${${var}}@${SiteConfigs[${var}]}@" ${ConfigFile}
done
chown -R www.www ${ConfigFile}

### 定义 Apache 配置文件
ExampleFile="/data/configs/apache/vhost.example"
ConfigFile="/data/configs/apache/vhost_${SiteSign}.conf"
\cp -fR "${ExampleFile}" "${ConfigFile}"
for var in ${!SiteConfigs[@]}
do
   sed -i "s@\${${var}}@${SiteConfigs[${var}]}@" ${ConfigFile}
done
[ -z "${ServerAlias}" ] && sed -i "/ServerAlias/d" ${ConfigFile}
chown -R www.www ${ConfigFile}

### 重启服务
nginx -v > /dev/null 2>&1
[ $? -eq 0 ] && systemctl restart nginx.service
httpd -v > /dev/null 2>&1
[ $? -eq 0 ] && systemctl restart httpd.service
