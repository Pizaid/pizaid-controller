#! /bin/bash
# extend a Pizaid-volume

# check argument
CMDNAME=`basename $0`
if [ $# != 2 ]; then
	echo "Usage: $CMDNAME PizaidVolumeName PhysicalDevicePath"
	exit 1
fi

# TODO: check VolumeName
VNAME=$1 #VolumeName
DPATH=$2 #DevicePath


# check machine
if [ `hostname` != "raspberrypi" ]; then
	echo "This machine is not raspberrypi"
	exit 1
fi


# check user
if [ "` id | grep root`" = "" ]; then
	echo "Please re-run as super user"
	exit 1
fi


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

# extend volume group
vgextend Pizaid-VG-${VNAME} ${DPATH}1

# extend logiacal volume
lvextend -l +100%FREE /dev/Pizaid-VG-${VNAME}/Pizaid-LV-${VNAME}

# format pertation with ext4
resize2fs /dev/Pizaid-VG-${VNAME}/Pizaid-LV-${VNAME}
