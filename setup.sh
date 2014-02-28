#! /bin/bash
# setupper for Pizaid-Controller

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

echo "start setup of Pizaid-Controller"

echo "update and install depend packages"
# update packages before install
aptitude update
aptitude upgrade

# install lvm and filesisytems packages
aptitude install lvm2

# # install samba
# aptitude install samba
