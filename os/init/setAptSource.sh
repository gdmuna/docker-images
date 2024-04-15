#!/bin/bash

# ubuntu amd64
cp -a /etc/apt/sources.list /etc/apt/sources.list.bak \
# change apt source to ustc
&& sed -i "s@http://.*archive.ubuntu.com@https://mirrors.ustc.edu.cn@g" /etc/apt/sources.list \
&& sed -i "s@http://.*security.ubuntu.com@https://mirrors.ustc.edu.cn@g" /etc/apt/sources.list \
&& apt-get update
