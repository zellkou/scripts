#!/bin/bash

for image in *.jpg *.JPG *.jpeg *.gif *.GIF *.bmp *.BMP *.png *.PNG;
    do res=$(identify -format %wx%h\\n $image);
    mkdir -p $res;
    mv $image $res;
done