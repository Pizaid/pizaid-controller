#! /bin/bash
# extend a Pizaid-volume

. pizaid-common.sh

# check argument
CMDNAME=`basename $0`
if [ $# != 2 ]; then
	echo "Usage: $CMDNAME PizaidVolumeName PhysicalDevicePath"
	exit 1
fi

# TODO: check VolumeName
VNAME=$1 #VolumeName
DPATH=$2 #DevicePath


PizaidCheckHostName
PizaidCheckUser

PizaidCheckDevicePATH

PizaidCreatePartition
PizaidCreatePV
PizaidExtendVG
PizaidExtendLV

PizaidReSizeFS
