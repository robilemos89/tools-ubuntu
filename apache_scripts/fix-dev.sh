#!/bin/sh
FILE_TLD=/etc/NetworkManager/dnsmasq.d/dev-tld

if [ ! -f $FILE_TLD ]; then
    echo address=/dev/127.0.0.1 | sudo tee $FILE_TLD > /dev/null
    sudo systemctl restart NetworkManager > /dev/null
fi
