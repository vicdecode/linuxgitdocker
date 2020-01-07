#!/bin/bash
#State the reason behind the new user account, this will be logged for admin purposes.
echo "NEW USER ACCOUNT"
echo "Reason for New Account:"
read reasonNewAcct
echo "Awesome, we are creating this account for ${reasonNewAcct}."
echo ".........................................................."
echo "Before we begin, let's check if we have privileges."
echo "Are you a SUDO user or ROOT? Type Y for Yes and N for No"
read amiroot
if [[ "$amiroot" == "Y" ]] || [[ "$amiroot" == "y" ]] || [[ "$amiroot" == "YES" ]] || [[ "$amiroot" == "yes" ]]
then
	reset
	echo "Checking if you are root......."
	sleep 2
	printf "%0.s." {1..10000}
	echo ""
	#Check if Root or Sudo
	amiadmin=$(groups | tr " ," "\n" | grep sudo)
	if [[ "$amiadmin" == "sudo" ]] || [[ "$UID" == 0 ]]
	then
		echo "Congratulations, you are ADMIN"
		echo "Let's continue"
		sleep 2
		reset
		#Prompt for username
		echo "Please enter new username"
		read newusername
		echo "Great, thanks ${newusername}"
		if [[ "$UID" == 0 ]]
		then
			useradd -m ${newusername}
		else
			sudo useradd -m ${newusername}
		fi
		echo "Creating your user directory now."
		echo "Will this user be Admin? Please enter Y for Yes or N for No"
		read newuseradmin
		if [[ "$newuseradmin" == "Y" ]] || [[ "$newuseradmin" == "Yes" ]] || [[ "$newuseradmin" == "yes" ]] || [[ "$newuseradmin" == "y" ]]
		then
			echo "Great, we will add this user to sudo group."
			if [[ "$UID" == 0 ]] 
			then
			usermod -a -G sudo $newusername
			else
			sudo usermod -a -G sudo $newusername
			fi
		else
			echo "Great, this user will be added as a regular user."
			sleep 1
		fi
		#Now let's change ownership of the home directory to belong to the new user
		chown $newuser
	else
		echo "You are not ROOT OR SUDO"
		echo "Stop Trying to hack jk"
		printf "%0.s." {1..1000}
		echo ""
		echo "If you reached this by mistake, please contact your administrator"
		exit
	fi
else
	echo "You are not a ROOT or SUDO user, please contact your administrator."
	exit
fi
