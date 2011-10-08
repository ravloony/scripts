#!/bin/bash

###############################################
#
#	Makes a web directory with attendant login.
#	mkwebuser.sh -u username -h home_dir -p password -g group
#	This presupposes  that the group for sftp user exists, and that ssh is configured correctly as per http://shapeshed.com/journal/chroot_sftp_users_on_ubuntu_intrepid/
#
###############################################

#argument counter
count=0

while getopts "h:u:p:g:" opt
do
	case $opt in
	u)
		USERNAME=$OPTARG
		echo "username is $USERNAME"
		((count++))
		;;
	h)
		HOMEDIR=$OPTARG
		echo "home directory is $HOMEDIR"
		((count++))
		;;
	p)
		PASSWORD=$OPTARG
		((count++))
		;;
	g)
		GROUP=$OPTARG
		((count++))
		;;
	\?)
      		echo "Invalid option: -$OPTARG" >&2
		;;
	:)
      		echo "Option -$OPTARG requires an argument." >&2
      		exit 1
      		;;
	esac
done

#validate options

if [ $count -eq 4 ]
then
	echo "Parameters validated"
else
	echo "Parameters not validated"
	exit 1
fi

#check options

if [[ -d /var/www/vhosts/$HOMEDIR ]]
then
	echo "directory already exists"
	exit 1
fi

/bin/id $USERNAME 2>/dev/null

if [[ $? -eq 0 ]]
then
	echo "user already exists"
	exit 1
fi

/bin/id -g $GROUP 2>/dev/null
if [[ $? -eq 1 ]]
then
	echo "Making group $GROUP"
#	groupadd $GROUP
fi


# make the user
echo "adding user $USERNAME with homedir $HOMEDIR"
#useradd -d /var/www/vhosts/$HOMEDIR $USERNAME

# set the password
echo "Setting password"
#echo $PASSWORD | passwd --stdin $USERNAME

# set to the sftp users group
echo "Adding $USERNAME to $GROUP group"
#usermod -g $GROUP $USERNAME

#set shell to nothing
echo "Setting false shell"
#usermod -s /bin/false $USERNAME
