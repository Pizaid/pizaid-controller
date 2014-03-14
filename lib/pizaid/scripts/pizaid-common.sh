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
    if [ ! -f $DPATH ]; then
	    echo "$DPATH is not exist or file"
	    exit 1
    fi

    if [ "` echo $DPATH | grep '^/dev/sd[a-z]$' `" ]; then
	    echo "$DPATH is invalid ( /dev/sd[a-z] is valid )"
	    exit 1
    fi
}
