#!/bin/bash

PASSWORD=$1
echo "root:$PASSWORD" | chpasswd
