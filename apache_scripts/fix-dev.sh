#!/bin/sh
echo address=/dev/127.0.0.1 | sudo tee /etc/NetworkManager/dnsmasq.d/dev-tld
sudo systemctl restart NetworkManager
