#!/bin/bash
#State the reason behind the new user account, this will be logged for admin purposes.
reset
printf "%0.s*"  {1..1000}
sleep .5s
reset
echo "BASH SCRIPTS BY Victor E."
echo "January 07, 2020"
echo "NEW USER ACCOUNT SCRIPT"
echo "Reason for New Account:"
read reasonNewAcct
echo "Awesome, we are creating this account ${reasonNewAcct}."
echo ".........................................................."
echo "Before we begin, let's check if we have administrative rights."
echo "Are you a SUDO user or ROOT? Type Y for Yes and N for No"
read amiroot
if [[ "$amiroot" == "Y" ]] || [[ "$amiroot" == "y" ]] || [[ "$amiroot" == "YES" ]] || [[ "$amiroot" == "yes" ]]
then
	reset
	echo "Checking if you are ROOT or an admin......."
	sleep 2
	printf "%0.s." {1..10000}
	echo ""
	#Check if Root or Sudo
	amiadmin=$(groups | tr " ," "\n" | grep sudo)
	if [[ "$amiadmin" == "sudo" ]] || [[ "$UID" == 0 ]]
	then
		echo "Congratulations, you are ADMIN"
		read -n 1 -s -r -p "Press any key to continue"
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
		clear
		#Now let's change ownership of the home directory to belong to the new user
		echo "Now we will give $newusername permissions to their home directory."
		if [[ "$UID" == 0 ]] 
		then
			chown $newusername /home/$newusername
		else
			sudo chown $newusername /home/$newusername
		fi
		sleep 1s
		cd /home && ls -l 
		echo $"Check the permissions of ${newusername}'s folder."
		read -n 1 -s -r -p "Press any key to continue"
		clear
		echo $"We want $newusername to be able to SSH into a remote server and connect, so we will create a folder called .ssh and a file inside called 'authorized_keys' and give them permission and deny every other user group / person."
		echo ""
		echo ""
		sleep 1s
		echo $"We will use the command 'mkdir .ssh && cd .ssh && touch authorized_keys' to do so."
		echo ""
		echo ""
		cd $newusername
		if [[ "$UID" == 0 ]] 
		then 
			mkdir .ssh && cd .ssh && touch authorized_keys
		else
			sudo mkdir .ssh && cd .ssh && sudo touch authorized_keys
		fi
		echo ""
		echo ""
		echo $"Now we will give permissions to ${newusername}'s ssh folder and authorized keys file."
		if [[ "$UID" == 0 ]]
		then
			chown $newusername /home/${newusername}/.ssh
			chmod 700 /home/${newusername}/.ssh
			chown $newusername authorized_keys
			chmod 600 authorized_keys
		else
			sudo chown $newusername /home/${newusername}/.ssh
			sudo chmod 700 /home/${newusername}/.ssh
			sudo chown $newusername authorized_keys
			sudo chmod 600 authorized_keys
		fi
		read -n 1 -s -r -p "Press any key to continue"
		echo ""
		ls -l
		read -n 1 -s -r -p "Press any key to continue"
		clear
		printf "%0.s Awesome" {1..1000}
		echo ""
		sleep 1s
		clear
		echo "We are now ready to add in the public key to our authorized keys file"
		sleep .5s
		morekeys="yes"
		while [[ "$morekeys" != "no" ]] && [[ "$morekeys" != "n" ]]
		do 
			echo $"Copy and paste in your public key starting with the key type, i.e. ssh-rsa ...."
			read rsapublickey 
			if [[ "$UID" == 0 ]] 
			then
				cat <<< $rsapublickey >> authorized_keys
			else
				sudo su -c "cat <<< $rsapublickey >> authorized_keys"
			fi
			echo $"Thank you for inputting your key, do you have more keys?"
			read morekeys
		done			 
		clear
		echo "Is this just for testing purposes?"
		read thisisatest
		if [[ "$thisisatest" == "yes" ]] || [[ "$thisisatest" == "YES" ]] || [[ "$thisisatest" == "y" ]] || [[ "$thisisatest" == "Yes" ]]
		then
			echo "Because this is just a test, we will delete everything we did."
			sleep 2
			sudo userdel $newusername
			sudo rm -r /home/${newusername}
		else
		echo "Your username and password have been saved accordingly."
		echo ""
		fi
		echo "Thank you for viewing our script. Have a blessed day."
		echo "Decode Digital x Vic - making the world go round."

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
