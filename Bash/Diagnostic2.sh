#!/bin/bash
# ======================================================================
# SCRIPT NAME: Diagnostic2.sh
# Description: Competency #2 : Creating User(s)
#
# REVISION HISTORY: N/A
#
# AUTHOR				DATE			DETAILS
# --------------------- --------------- --------------------------------
# Sterling McKinley	 2022-07-30	  Initial version
#
# ======================================================================

#Prevents a regular user from running this script
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

#VARIABLE ASSIGNMENT
first=$1
last=$2
group=$3
shell=$4
passwd=$5

#Asking for new user input
echo " "
echo "To create the a new user the following details are needed"
echo " "
echo "=================================================="
echo " "

echo "1)Full Name 2)Shell 3)Group 4)Create a password"
echo " "
echo "=================================================="
echo "Please be sure to place a space between each of the requested details"
echo " "

echo "Example: John Doe /bin/bash cohort3 passwd"
echo "=================================================="
echo " "

if  [[ -z "$first" || "$last" || "$shell" || "$group" || "$passwd" ]]; then
#   echo "This script must be run as root" 1>&2
	echo " "
	echo "*ERROR* : 'USER DETAIL(S) MISSING' "
   exit 1
fi

#Storing input variables
read -r first last shell group passwd
echo "Full Name:" "$first" "$last"
echo "Shell:" "$shell"
echo "Group:" "$group"

echo Your password is: "$passwd"

echo " "
echo "=================================================="
echo "=================================================="
echo "One Moment...Storing input before creating a new user"

sleep 1s
echo "=================================================="
echo "=================================================="
echo " "

#Creating new user
echo "A New user has been created"

#Creating a username
username="$( echo "$first"| cut -c 1 | tr 'A-Z' 'a-z')$(echo "$last" | tr 'A-Z' 'a-z')"
echo "Your username is:" "$username"
sudo useradd -M "$username" -s "$shell"
sudo groupadd "$group"

echo " "
echo "$username","$group","$passwd"