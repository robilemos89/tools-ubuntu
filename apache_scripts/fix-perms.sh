#!/bin/bash

if [ $# = 1 ]; then
    sudo setfacl -R -m g:www-data:rwx $1
    sudo chown `whoami`:`whoami` $1
    sudo chmod -R 775 $1
    sudo chmod -R g+s $1
    sudo chmod -R u+s $1
fi
