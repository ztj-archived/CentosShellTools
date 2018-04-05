#!/bin/sh

stty erase ^H
stty kill ^U
echo -en "SSH to Host :"
read host
echo -en "UserName: "
read username
/usr/bin/ssh $host -l $username
