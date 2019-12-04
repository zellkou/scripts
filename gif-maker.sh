echo Input file name
read video

#fps = 'ffmpeg -i $video 2>&1 | sed -n "s/.*, \(.*\) fp.*/\1/p"'
f = 25
vf = $video$f
fps1 = eval $fps


mkdir $vf

ffmpeg -i $video -r $fps1 $vf/frame-%03d.jpg

echo convert finished
echo name gif

read gifname

convert -delay 20 -loop 0 $vf/*.jpg $vf/$gifname.gif
