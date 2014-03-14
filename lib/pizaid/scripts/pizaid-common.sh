#! /bin/bash
# common funcs

PizaidCheckHostName(){
    if [ `hostname` != "raspberrypi" ]; then
	    echo "This machine is not raspberrypi"
	    exit 1
    fi
}

PizaidCheckUser(){
    if [ "` id | grep root`" = "" ]; then
	    echo "Please re-run as super user"
	    exit 1
    fi
}

PizaidCheckVolumeName(){
    if [ "` echo $VNAME | grep '[^A-Za-z0-9]' `" != "" ]; then
	    echo "Unacceptable PizaidVolumeName: $VNAME (You can use A-Z,a-z and 0-9)"
	    exit 1
    fi

    if [ "` echo $VNAME | grep 'sync'`" != "" ]; then
	    echo "Unacceptable PizaidVolumeName: $VNAME (can not use "sync" for PizaidVolumeName)"
	    exit 1
    fi
}

PizaidCheckDevicePATH(){
    if [ ! -e $DPATH ]; then
	    echo "$DPATH is not exist"
	    exit 1
    fi

    if [ "` echo $DPATH | grep '^/dev/sd[a-z]$' `" ]; then
	    echo "$DPATH is invalid ( /dev/sd[a-z] is valid )"
	    exit 1
    fi
}



PizaidCreatePartition(){
    fdisk $DPATH << EOF
o
n
p
1


t
8e
w
EOF
}

PizaidCreatePV(){
    pvcreate ${DPATH}1
}

PizaidCreateVG(){
    vgcreate -s 128m Pizaid-VG-${VNAME} ${DPATH}1
}

PizaidCreateLV(){
    lvcreate -n Pizaid-LV-${VNAME} -l 100%FREE Pizaid-VG-${VNAME}
}

PizaidExtendVG(){
    vgextend Pizaid-VG-${VNAME} ${DPATH}1
}

PizaidExtendLV(){
    lvextend -l +100%FREE /dev/Pizaid-VG-${VNAME}/Pizaid-LV-${VNAME}
}

PizaidMKFS(){
    mkfs -t ext4 /dev/Pizaid-VG-${VNAME}/Pizaid-LV-${VNAME}
}

PizaidReSizeFS(){
    resize2fs /dev/Pizaid-VG-${VNAME}/Pizaid-LV-${VNAME}
}
