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


# create pertation for volume group
fdisk $DPATH << EOF
o
n
p
1


t
8e
w
EOF
# (end of fdisk)

# create phisycal volume for volume group
pvcreate ${DPATH}1

# create volume group
vgcreate -s 128m Pizaid-VG-${VNAME} ${DPATH}1

# create logiacal volume
lvcreate -n Pizaid-LV-${VNAME} -l 100%FREE Pizaid-VG-${VNAME}

# format pertation with ext4
mkfs -t ext4 /dev/Pizaid-VG-${VNAME}/Pizaid-LV-${VNAME}

# crate directory and mout
mkdir -p /media/Pizaid-${VNAME}
mount /dev/Pizaid-VG-${VNAME}/Pizaid-LV-${VNAME} /media/Pizaid-${VNAME}
