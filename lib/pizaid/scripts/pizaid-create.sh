#! /bin/bash
# create a Pizaid-volume

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

# check volume name
if [ "` echo $VNAME | grep '[^A-Za-z0-9]' `" != "" ]; then
	echo "Unacceptable PizaidVolumeName: $VNAME (You can use A-Z,a-z and 0-9)"
	exit 1
fi

if [ "` echo $VNAME | grep 'sync'`" != "" ]; then
	echo "Unacceptable PizaidVolumeName: $VNAME (can not use "sync" for PizaidVolumeName)"
	exit 1
fi

# check device
if [ ! -f $DPATH ]; then
	echo "$DPATH is not exist or file"
	exit 1
fi

if [ "` echo $DPATH | grep '^/dev/sd[a-z]$' `" ]; then
	echo "$DPATH is invalid ( /dev/sd[a-z] is valid )"
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

# create volume group
vgcreate -s 128m Pizaid-VG-${VNAME} ${DPATH}1

# create logiacal volume
lvcreate -n Pizaid-LV-${VNAME} -l 100%FREE Pizaid-VG-${VNAME}

# format pertation with ext4
mkfs -t ext4 /dev/Pizaid-VG-${VNAME}/Pizaid-LV-${VNAME}

# crate directory and mout
mkdir -p /media/Pizaid-${VNAME}
mount /dev/Pizaid-VG-${VNAME}/Pizaid-LV-${VNAME} /media/Pizaid-${VNAME}
