#! /bin/bash
# create a Pizaid-volume

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

PizaidCheckVolumeName
PizaidCheckDevicePATH


PizaidCreatePartition
PizaidCreatePV
PizaidCreateVG
PizaidCreateLV
PizaidMKFS


# crate directory and mout
mkdir -p /media/Pizaid-${VNAME}
mount /dev/Pizaid-VG-${VNAME}/Pizaid-LV-${VNAME} /media/Pizaid-${VNAME}
