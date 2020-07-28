#!/bin/bash
echo $(date) >> /home/$USER/converted.txt

for i in *.mp4;
    do
        if [ $(ffprobe -v error -select_streams v:0 -show_entries stream=codec_name -of default=noprint_wrappers=1:nokey=1 $i) -eq hevc ] then;
            echo "HEVC"
            echo "$i" >> /home/$USER/converted.txt
        else
            ffmpeg -i $i -c:v libx265 ${i%.*}.h265.mp4
            echo "$i" >> /home/$USER/converted.txt
        fi
        rm $i
done

for x in *.h265.mp4;
    do mv $x ${x/.h265.mp4/.mp4};
done

echo $(date) >> /home/$USER/converted.txt
