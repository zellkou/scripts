#!/bin/bash
echo "Input first directory"
read first
for i in $first/*
    do md5deep $i | tee -a ~/1.txt;
done

echo "Input second directory"
read second
for n in $second/*
    do md5deep $n | tee -a ~/2.txt;
done

sed 's/\s.*$//' 1.txt | tee -a 3.txt;
sed 's/\s.*$//' 2.txt | tee -a 4.txt;
diff 3.txt 4.txt | tee -a 5.txt;