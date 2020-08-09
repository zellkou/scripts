#!/bin/bash

# This adds domains to pihole list
echo "Input domain to banish";
read -r i;
ssh -t pihole "echo $i >> ~/Documents/adlist.txt";
exit
