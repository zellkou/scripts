#!/bin/bash
i="${i%.*}"
sudo ip link add link $1 name eth$i type vlan id $2 &&
echo "IP in CIDR"
read $ip
a="${ip%.*}"
mcast=$a.255
sudo ip addr add $ip brd $mcast dev eth$i &&
sudo ip link set dev eth$i up
