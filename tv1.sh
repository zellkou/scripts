#!/bin/bash

epnum=1

for file in *.mkv *.mp4;
    do showname=${PWD##*/}
        if [ $epnum -lt 10 ]; then
            name=$showname.S00E0$epnum
            fullname=$name.$file
            echo $file
            echo $fullname
            mv $file $fullname
            epnum=$((epnum+1))
        else name=$showname.S00E$epnum
            fullname=$name.$file
            echo $file
            echo $fullname
            mv $file $fullname
            epnum=$((epnum+1))
        fi
done
