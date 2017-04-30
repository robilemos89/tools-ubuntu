#!/bin/bash
if [ $# -gt 1 ]; then
    sudo setfacl -r -m g:www-data:rwx $1
    sudo chmod -R g+s $1
    sudo chmod -R u+s $1
fi
