#!/bin/bash
# We will let the user know what the script is.
echo "Welcome to Linux Upgrade Script by Teknixco"
# We will prompt the user for their name
echo "Please enter your name"
read name
# Salutations
echo "Nice to meet you! ${name}."
echo ".........................."
echo "What cars do you like?"
read car1 car2 car3
echo "Your first car was: $car1"
echo "Your second car was $car2"
echo "Your third car was  $car3"
echo ".........................."
echo "All this is actually irrelevent."
echo "LETS UPGRADE OUR SYSTEM!"
echo "Are you the Root? Type Y for Yes and N for No"
read amiroot
if [[ "$amiroot" == "Y" ]]
then
echo "Okay great"
sudo apt-get update > log.txt
sudo apt-get upgrade >> log.txt
else
exit
fi

