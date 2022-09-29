#!/usr/bin/python
# =======================================================================
# SCRIPT NAME: Diagnostic6_2.py
#
# Description: This script was part of Diagnostic 6. This script will: 
#               1- check system CPU or MEMORY usage
#               2- kill a program 
#               3- notify the user about the killed program      
#
# REVISION HISTORY: N/A
#
# AUTHOR		   DATE			DETAILS
# --------------------- --------------- ---------------------------------
# Sterling McKinley	 2022-08-29	  Initial version
# =======================================================================

import psutil
import os
import time
import subprocess

#Prints CPU using psutil module
print('Your current CPU utilization is: ', psutil.cpu_percent(5), '\n') 

#Prints Memory using psutil module
print('You current RAM memory utilization is:', psutil.virtual_memory()[2], '%', '\n')

print('Lets check processes that are currently running...', '\n')
time.sleep(2)

#calls a bash script to check server resources using psutil module
#the called bash script will ask the user to kill the selected program
#buildscript2.sh is located in KuraLabs/Bash_Scripts folder
exit_code = subprocess.call('./buildscript2.sh')
print(exit_code)