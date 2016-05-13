#!/bin/sh

# Hi! it's me - Jixian Wang!
# if you like this script, please drop me an email at hellojixian@gmail.com for any questions
# I would like to meet and discus some tech topics with you!

# check permission, 
# because of we need to update system configuration 
# so root permission is requried
if [ ! `whoami` == "root" ] ; then
	echo "Need root permission to permanently fix the issue"
	echo "Please try it with sudo like below:"
	echo "
	sudo $0
		"
	exit 1;
fi

#check if linux.ko loaded
if ! (kldstat -v | grep -q linux.ko); then
	kldload linux.ko
fi

#make linux.ko auto loaded in next boot time
if ! (cat /etc/rc.conf | grep -q linux_enable=\"YES\"); then 
	echo linux_enable="YES" >> /etc/rc.conf
fi


# try to mount all before test each pseudo fs
mount -a

#fix /proc
if ! (mount | grep -q "devfs\s*on"); then
	if [ ! -d /proc ]; then
		mkdir /proc
	fi	
	printf "proc\t\t\t/proc\tprocfs\trw\t0\t0\n" >> /etc/fstab
fi

#fix /dev/fd
if ! (mount | grep -q "fdesc\s*on"); then
	printf "fdesc\t\t\t/dev/fd\tfdescfs\trw\t0\t0\n" >> /etc/fstab
fi

#fix /tmpfs
if ! (mount | grep -q "tmpfs\s*on"); then
	if [ ! -d /tmpfs ]; then
		mkdir /tmpfs
	fi
	printf "tmpfs\t\t\t/tmpfs\ttmpfs\trw,mode=777\t0\t0\n" >> /etc/fstab
fi


#fix devfs
if ! (cat /etc/devfs.conf | grep -q "link\s*/tmpfs\s*shm"); then
	printf "link\t/tmpfs\tshm\n" >> /etc/devfs.conf
	/etc/rc.d/devfs restart
fi

# try to mount them all again
mount -a

# if the main entry point is not exists then need to reinstall it
if [ ! -f /usr/local/bin/sublime ]; then
	pkg update
	pkg install -f linux-sublime3
fi

# there you go , fixed 
/usr/local/bin/sublime