NOWIPADDR="nowipaddr"
GETIPADDR="ifconfig.me"


    if [ -f $NOWIPADDR ]
    then
       if [ `cat $NOWIPADDR` = `curl $GETIPADDR` ]
       then
           echo "no change in IP."
       else
           $GETIPADDR > $NOWIPADDR
           mail -s "IP is $GETIPADDR" yourmailadd@gmail.com
        fi
    else
        curl $GETIPADDR >> $NOWIPADDR
    fi
