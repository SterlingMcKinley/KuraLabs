#!/bin/bash
# ======================================================================
# AUTHOR				DATE		COMMENTS/UPDATES
# ----------------- ----------- --------------------------------
# Sterling McKinley	 2022-08-06	  Initial version
#
# Description: This script will verify if a package is installed. The user will provide 
#               input <package name>. The script will take user input and search 
#               for the desired package.
#
# SCRIPT NAME: diagnostic3.sh
# ======================================================================
package=$1

echo "Specify the below package you would like to verify is installed...."

read -r package

if apt list --installed | grep "$package";
then
    echo "dpkg -s" "$package"
else
   echo "$package" "is NOT installed" 
fi



