#!/bin/bash

for i in *.mp4;
  do
  # remove file extension
    a="${i%.*}"
    b=$a.1.mp4
  # replace . with space in title
    f="${a/\./ }";
  # debugging echos
    echo "$i"
    echo "$a"
    echo "$f"
    echo "$b"
  # edit metadata
    ffmpeg -i "$i" -codec copy -metadata title="$f" "$b"
    mv "$b" "$i"
done
