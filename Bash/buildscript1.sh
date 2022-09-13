#!/bin/bash
# ======================================================================
# AUTHOR				DATE		COMMENTS/UPDATES
# ----------------- ----------- --------------------------------
# Sterling McKinley	 2022-07-30	  Initial version
#
# Description: This script will automatically update a server's software weekly,
#               every Friday at 11pm. In addition, an output file will be generated
#               providing details as to what was updated.
#
#              1-This cronjob was created by adding the user of this script to the /etc/sudoers file.
#              2-Find the script and copy it to /home/$USER directory
#              3-Adding cronjob to the /etc/crontab file
#              4-Update the Ubuntu repos / system check against repos
#              5-List upgradeable packages then append activity to cronlog
#              6-install packages & a log file is generated listing installed packages by date
#
#
# SCRIPT NAME: buildscript1.sh
# ======================================================================

echo "This script will create a cronjob (which will run every Friday at 11pm)"
echo "that will locate new versions/additions of installed packages, "
echo "list the available upgrades then update packages."
echo " "
echo " "
echo " Starting script....."
echo " "


#Creating a log variable
cronlog=~/cronjob_logs

#Checking if a cron log directory exists a for weekly cronlogs. 

if [ ! -d "$cronlog" ];
then
    mkdir "$cronlog";chmod -R 755 "$cronlog" && echo "PLEASE BE AWARE CRON JOB LOGS WILL RESIDE IN ~/cronjob_logs DIRECTORY."
fi

sleep 1s


#Append to the sudoers file to allow user to execute sudo command without being prompt for a password

echo "$USER" ALL='(ALL)' NOPASSWD:ALL | sudo tee -a /etc/sudoers

#Finding the script and copying script to the user home path folder

find /home -name buildscript1.sh -exec cp "{}" /home/"$USER"/buildscript1 \;

#Adding cronjob to the crontab file

sudo echo "0 23 * * 5 $USER /home/$USER/buildscript1.sh >/dev/null 2>&1" | sudo tee -a /etc/cron.weekly/package-update
sleep 1s
echo " "

#Executing command to update the Ubuntu repositories
echo "Downloading package lists & find the latest version(s) of the packages...."
sudo apt-get update

sleep 3s


#Executing a command to list upgradeable packages
echo " "
echo " "

echo "Listing upgradeable packages..."
sudo apt list --upgradeable

sleep 3s

#Exceuting a command to install packages with option -y to install without user interaction
sudo apt upgrade -y >> "$cronlog"/cronlog"$(date +"%M-%d-%Y %T")".log

sleep 1s

#Writes installed package info (by date) to a log
grep " install " /var/log/dpkg.log >> "$cronlog"/installed_cronlog"$(date +"%Y-%M-%d %T")".log

echo "TO REVIEW NEW UPDATES, PLEASE REFER TO CRONLOGS IN THIS PATH" "$cronlog"