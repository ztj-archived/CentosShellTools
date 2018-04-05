#!/bin/bash

###############
# Name: 开启 SHH
# author: ZhangTianJie
# email: ztj1993@gmail.com
###############

docker exec ${ContainerName} yum install openssl openssh-server -y
docker exec ${ContainerName} ssh-keygen -q -t rsa -b 2048 -f /etc/ssh/ssh_host_rsa_key -N ''
docker exec ${ContainerName} ssh-keygen -q -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N ''
docker exec ${ContainerName} ssh-keygen -t dsa -f /etc/ssh/ssh_host_ed25519_key  -N ''
docker exec ${ContainerName} sed -i "s/#UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config
docker exec ${ContainerName} sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config
docker exec ${ContainerName} systemctl start sshd.service
docker exec ${ContainerName} systemctl enable sshd.service

