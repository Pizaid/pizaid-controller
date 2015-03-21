#! /bin/bash
# common funcs

PizaidCheckHostName(){
    if [ "`grep Raspbian /etc/issue`" = "" ]; then
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
    vgcreate -s 128m ${NAME}-VG ${DPATH}1
}

PizaidCreateLV(){
    lvcreate -n ${NAME}-LV -l 100%FREE ${NAME}-VG
}

PizaidExtendVG(){
    vgextend ${NAME}-VG ${DPATH}1
}

PizaidExtendLV(){
    lvextend -l +100%FREE /dev/${NAME}-VG/${NAME}-LV
}

PizaidMKFS(){
    mkfs -t ext4 /dev/${NAME}-VG/${NAME}-LV
}

PizaidReSizeFS(){
    resize2fs /dev/${NAME}-VG/${NAME}-LV
}
