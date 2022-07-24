#!/bin/bash
# ======================================================================
# SCRIPT NAME: ipscript.sh
#
# PURPOSE: KuraLabs Bash Scripting Task#1 | This script will read a file that contains a list of IP 
# addresses, select an IP then SSH into the selected IP.
#
# REVISION HISTORY: N/A
#
# AUTHOR				DATE			DETAILS
# --------------------- --------------- --------------------------------
# Sterling McKinley	 2022-07-23	  Initial version
# ======================================================================

#VARIABLE ASSIGNMENT
iplist=/home/sterling/Desktop/iplist.txt

#Displaying a list of ip addresses from a file
cat "$iplist"

#Requesting the desired IP ADDRESS (user input)
echo " "
echo "Which IP ADDRESS would you like to connect to?"; 

#Reading the user input(IP ADDRESS) then taking the input
#from the read command
read -r
echo "ssh into $REPLY"

#SSH into the selected IP ADDRESS using a private.pem
ssh -i private.pem ubuntu@"$REPLY"
exit
