#!/bin/bash
a="$(docker image ls | sed 's/|/ /' | awk '{print $1}')"
b="$(docker container ls | sed 's/|/ /' | awk '{print $1}')"

for i in $a;
  do if [[ $i == REPOSITORY ]];
        then echo "repository";
     else
        echo $i;
        docker pull $i &>> ~/docker.update.log;
     fi
done

for i in $b;
  do if [[ $i == CONTAINER ]];
        then echo "container";
     else
        echo $i;
        docker restart $b &>> ~/docker.update.log;
        docker image prune -f &>> ~/docker.update.log;
     fi
done

exit 0
