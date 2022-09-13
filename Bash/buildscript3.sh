#!/bin/bash
# ======================================================================
# SCRIPT NAME: buildscript3.sh
# Description: Creating User(s) & Git Repo management & Managing sensitive info
#
# REVISION HISTORY: N/A
#
# AUTHOR		   DATE			DETAILS
# --------------------- --------------- --------------------------------
# Sterling McKinley	 2022-08-13	  Initial version
#
# ======================================================================
bscript3=$(dirname "$0")/buildscript3_1.sh

echo "***IMPORTANT*** ***IMPORTANT*** ***IMPORTANT***"
echo " "
echo "In this script, a user will be created, files will be created,"
echo "and a 2nd script will be called at the end of this script."
echo " "
echo "PLEASE NAVIGATE TO THE LOCATION OF A WORKING .GIT REPOSITORY..."
echo "AND COPY BOTH SCRIPTS {buildscript3.sh & buildscript3_1.sh TO A"
echo "WORKING .GIT REPOSITORY/DIRECTORY."
echo "==============================================================="

sleep 2s
#Listing all repos
echo "Here are the local .git repositories/directories on this server..."
sudo find /home -name .git | nl

sleep 1s
echo " "
read -p "ARE YOU IN A .GIT REPOSITORY LOCATION? TYPE YES OR NO BELOW? >>>" input

input=$( echo "$input" | cut -c 1 | tr [A-Z] [a-z])

if [[ $input == 'y' ]];
    then
    echo "---------------------------------------------------"
    echo "Lets proceed with the script...."
else
    echo "This script must be executed in a .git repository directory" 1>&2
    exit 1
fi

#Prevents a regular user from running this script
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

#VARIABLE ASSIGNMENT
first=$1
last=$2
shell=$3
group="GitAcc"

#Asking for new user input
echo " "
echo "To create the a new user the following details are needed"
echo " "
echo "=================================================="
echo " "

echo "1)Full Name 2)Shell 3)Create a password"
echo " "
echo "=================================================="
echo "Please be sure to place a space between each of the requested details"
echo " "

echo "Example: John Doe /bin/bash"
echo "=================================================="
echo " "


#Storing input variables
read -r first last shell
echo "Full Name:" "$first" "$last"
echo "Shell:" "$shell"
echo "Group:" "$group"

echo " "
echo "=================================================="
echo "=================================================="
echo "One Moment...Storing input before creating a new user"

sleep 1s

echo "=================================================="
echo "=================================================="
echo " "

#Creating a username
echo "Please following the prompts and provide the required user information...."
sudo adduser --force-badname "$first"

#Creating GitAcc group
sudo groupadd "$group"
echo " "

#Adding user to GitAcc group
sudo adduser "$first" sudo
echo " "
sudo usermod -a -G ${group},sudo "$first"
echo " "
echo "USER $first HAS BEEN CREATED and ADDED to the FOLLOWING $group."
echo " "

#Switching to the newly created user
su -u "$first"

echo " "

#source=src/buildscript3_1.sh
source "$bscript3"