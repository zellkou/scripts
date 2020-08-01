#!/bin/bash
for i in *.aax;
    do ffmpeg -activation_bytes xxxxxxxx -i "$i" -vn -c:a copy "${i%.*}.m4b";
done
mv ~/Downloads/aax/*.m4b ~/Music/audibooks
