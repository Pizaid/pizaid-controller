#! /bin/bash
# check disk space of Pizaid-volume

. pizaid-common.sh

NAME="Pizaid"
PERCENT_FLAG=false

# check argument
CMDNAME=`basename $0`
usage_exit() {
	echo "Usage: $CMDNAME [-S sync] [-p percent] [-s size] [-u use] [-a avail] [-h help]" 1>&2
    exit 1
}

MODE="NO"

OPT=`getopt -o :Spsuah -l sync,percet,size,use,avil,help -- "$@"`
if [ $? != 0 ] ; then
    usage_exit
fi
eval set -- "$OPT"
while [ $# -gt 0 ]; do
    case $1 in
        -S | --sync) NAME="Pizaid-Sync";;
        -p | --percent) PERCENT_FLAG=true;;
        -s | --size) MODE="SIZE";;
        -u | --use) MODE="USE";;
        -a | --avail) MODE="AVAIL";;
        -h | --help) usage_exit;;
        --) shift; break ;;
    esac
    shift
done

if [ $# != 0 ] ; then
    usage_exit
fi

if [ $MODE == "SIZE" ] ;then
    echo `df | grep "/mnt/${NAME}$" | awk '{print $2}'`
elif [ $MODE == "USE" ] ; then
    if [ $PERCENT_FLAG == false ]; then
        echo `df | grep "/mnt/${NAME}$" | awk '{print $3}'`
    else
        echo `df | grep "/mnt/${NAME}$" | awk '{print $5}'`
    fi
elif [ $MODE == "AVAIL" ] ; then
    if [ $PERCENT_FLAG == false ]; then
        echo `df | grep "/mnt/${NAME}$" | awk '{print $4}'`
    else
        echo $(( 100 - $(df | grep "/mnt/${NAME}$" | awk '{print $5}' | sed 's/%//') ))%
    fi
else
    usage_exit
fi

exit 0
