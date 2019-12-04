#!/bin/bash

# This adds domains to pihole list
echo "Input domain to banish";
read i;
ssh -t needle "echo $i >> ~/Documents/adlist.txt";
exit