#!/bin/bash
# ======================================================================
# SCRIPT NAME: Diagnostic1.sh
#
# Description: broken.sh is part of diagnostic1 in an effort to 
#               -test my understanding of Bash concepts
#               -troubleshoot/fix the script 
#               -update/upgrade software packages.
#
# REVISION HISTORY: N/A
#
# AUTHOR		   DATE			DETAILS
# --------------------- --------------- --------------------------------
# Sterling McKinley	 2022-07-26	  Initial version
#
# ======================================================================
#Hello user!! This script will automatically update and upgrade your system ;-)
#You need to be a superuser to run the script!!
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

#Below will update the repositories the apt command is aware of.

while [ "$UID" = 0 ];
 do
	apt -y update
	exit 
done

#Next we want to prompt the user if they would like to proceed. 
echo "You are about to upgrade, would you like to proceed?" 
read -r $ans2
ans2=$(echo "$ans2" | cut -c 1 | tr '[:upper:]' '[:lower:]' )

#If the user answers yes, then the system will upgrade/install the updated packages.

if [ "$ans2" = "y" ];
 then
   apt -y upgrade;
   exit 0
fi