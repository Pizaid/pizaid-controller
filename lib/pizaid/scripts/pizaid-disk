#! /bin/bash
# create a Pizaid-volume

. pizaid-common.sh

NAME="Pizaid"

# check argument
CMDNAME=`basename $0`
usage_exit() {
	echo "Usage: $CMDNAME [-S sync] [-h help] PhysicalDevicePath" 1>&2
    exit 1
}

OPT=`getopt -o :Sh -l sync,help -- "$@"`
if [ $? != 0 ] ; then
    usage_exit
fi
eval set -- "$OPT"
while [ $# -gt 0 ]; do
    case $1 in
        -s | --sync) NAME="Pizaid-Sync";;
        -h | --help) usage_exit ;;
        --) shift; break ;;
    esac
    shift
done

if [ $# != 1 ] ; then
    usage_exit
fi

DPATH=$1 #DevicePath
PizaidCheckHostName
PizaidCheckUser

PizaidCheckDevicePATH

PizaidCreatePartition
PizaidCreatePV
PizaidCreateVG
PizaidCreateLV
PizaidMKFS


# crate directory and mout
mkdir -p /mnt/${NAME}
mount /dev/${NAME}-VG/${NAME}-LV /mnt/${NAME}
chown share:share /mnt/${NAME}

service samba restart
