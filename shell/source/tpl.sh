#!/bin/bash

###############
# Name: 简单模板引擎
# author: ZhangTianJie
# email: ztj1993@gmail.com
###############

### 判断是否设置了模板内容变量
if [ "${TplContent}" == "" ]; then
    echo ">>>>> Error: the var <TplContent> does not exist"
    exit 0
fi

### 替换所有的 $ 为 \$
TplContent=${TplContent//\$/\\\$}

### 将所有的变量和语句中的 \$ 替换 $
TplContent=$(echo "${TplContent}" | sed -E '/<[%|{]=.+?=[%|}]>/ s/\\\$/$/g')

### 替换所有的非语句中的 " 为 \"
TplContent=$(echo "${TplContent}" | sed -e '/^<{=/! s/\"/\\\"/g')

### 将所有的非语句 echo 一下
TplContent=$(echo "${TplContent}" | sed -e '/^<{=/! s/^.*$/echo "&"/')

### 替换掉所有的模板标签
TplContent=$(echo "${TplContent}" | sed -e 's/<{=\|=}>\|<%=\|=%>//g')

### 执行字符串
TplContent=$(eval "${TplContent}")
