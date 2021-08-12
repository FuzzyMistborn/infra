#!/bin/bash
# Modified from https://mullvad.net/en/help/running-wireguard-router/
# and https://wiki.r-selfhosted.com/guides/virtual-private-networks/wireguard/
# ping Wireguard gateway to test for connection
# if no contact, restart!

PING=/bin/ping
## DEBIAN
SERVICE=/usr/sbin/service

tries=0
while [[ $tries -lt 3 ]]
do
    if $PING -c 1 10.10.10.1
    then
            echo "wg works"
            exit 0
    fi
    echo "wg fail"
    tries=$((tries+1))
done
echo "wg failed 3 times - restarting tunnel"
## DEBIAN
$SERVICE wg-quick@wg0 restart