#!/bin/bash

epnum=1

for file in *.mkv;
    do name=${PWD##*/}
       name1=$name.S00E$epnum
       newname=$name1.$file
       echo $file
       echo $newname
       epnum=$((epnum+1))
       #mv $file $newname
done
