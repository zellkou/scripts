# Get users with sudo
users=( $(grep '^sudo:.*$' /etc/group | cut -d: -f4))

# Get length of array
tLen=${users[@]}

# Get full name
name=$(finger ${users[$i]} | cut -f3 -d":" )

# Get UID
uid=$(id ${users[$i]} | cut -c5-8 )

# Get passwd info
#pass=$(chage -l ${users[$i]} )

# Get passwd status for users
for (( i=0; i<${tLen}; i++ ));
do
    chage -l ${users[$i]}
    echo | USER  | UID  | FULL NAME | LASTCHANGE | MIN | MAX | WARN | PASSWD EXP | DIS | ACCT EXP |
    echo | ${users[$i]} | $uid | $name |
    echo this loop is working
done

echo "this script is working"