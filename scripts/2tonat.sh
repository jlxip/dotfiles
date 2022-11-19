#!/bin/bash -x
sudo ip addr add 192.168.122.2 dev virbr0
sudo iptables -t nat -A PREROUTING -i virbr0 -d 192.168.122.2 -j DNAT --to-destination 192.168.0.2
