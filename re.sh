#!/bin/bash

#list current dir
ls -aFB --color=auto --group-directories-first;

#starting point loop
echo 'Please choose starting point of renaming or tyoe exit to quit'
read startpoint
if [$startpoint == 'exit'];
	then
	break
	echo 'exiting'
else echo 'startpoint set to' $startpoint
fi

#filytype loop
echo 'Please choose filetype including the dot or type exit to quit'
read filetype
if $filetype = exit;
	then
	break
	echo 'exiting'
else echo 'filetype set to' $filetype
fi

#renaming loop
for file in *$filetype;
	do str="$file";
	mv $file ${str%%}$startpoin$fileype;
done

