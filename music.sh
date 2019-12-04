#!/bin/bash

for song in *.mp3;
    do artist=$(identify -format %wx%h\\n $song);
    mkdir -p $artist;
    mv $song $artist;
done
