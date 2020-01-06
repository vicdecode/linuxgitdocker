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
echo "Checking if you are root........"
#Check if Root or Sudo
amiadmin=$(groups | tr " ," "\n" | grep sudo)
#if [[ "$UID" == 0 ]] || if grep root list.txt
if [[ "$amiadmin" == "sudo" ]] || [[ "$UID" == 0 ]]
then
echo "Let's continue"
else
echo "You are not ROOT OR SUDO"
echo "Stop Trying to hack jk"
echo "........................"
echo "If you reached this by mistake, please contact your administrator"
exit
fi
else
echo "You are not a ROOT or SUDO user, please contact your administrator."
exit
fi
