#! /bin/bash
# create a Pizaid-volume

. pizaid-common.sh

# check argument
CMDNAME=`basename $0`
if [ $# != 1 ]; then
	echo "Usage: $CMDNAME PhysicalDevicePath"
	exit 1
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
mkdir -p /mnt/Pizaid
mount /dev/Pizaid-VG/Pizaid-LV /mnt/Pizaid
