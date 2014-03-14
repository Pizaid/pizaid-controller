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

PizaidCheckDevicePATH(){
    if [ ! -e $DPATH ]; then
	    echo "$DPATH is not exist"
	    exit 1
    fi

    if [ "` echo $DPATH | grep '^/dev/sd[a-z]$' `" = "" ]; then
	    echo "$DPATH is invalid ( /dev/sd[a-z] is valid )"
	    exit 1
    fi
}



PizaidCreatePartition(){
    parted $DPATH --script << EOF
mklabel gpt
mkpart primary 0% 100%
set 1 lvm on
quit
EOF
}

PizaidCreatePV(){
    pvcreate ${DPATH}1 -ff -y
}

PizaidCreateVG(){
    vgcreate -s 128m Pizaid-VG ${DPATH}1
}

PizaidCreateLV(){
    lvcreate -n Pizaid-LV -l 100%FREE Pizaid-VG
}

PizaidExtendVG(){
    vgextend Pizaid-VG ${DPATH}1
}

PizaidExtendLV(){
    lvextend -l +100%FREE /dev/Pizaid-VG/Pizaid-LV
}

PizaidMKFS(){
    mkfs -t ext4 /dev/Pizaid-VG/Pizaid-LV
}

PizaidReSizeFS(){
    resize2fs /dev/Pizaid-VG/Pizaid-LV
}
