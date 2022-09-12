#!/bin/bash
# ======================================================================
# SCRIPT NAME: Diagnostic5.sh
# Description: Create a script that will automate 
#               the creation of the Memory and CPU usage file, and push 
#                   the file to your repository.
#
# REVISION HISTORY: N/A
#
# AUTHOR		   DATE			DETAILS
# --------------------- --------------- --------------------------------
# Sterling McKinley	 2022-08-20	  Initial version
# ======================================================================
mem=$(free -t | awk 'NR == 2 {printf("%.2f%"), $3/$2*100}')
cpu=$(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage "%"}')
current_time=$(date "+%Y.%m.%d-%H.%M.%S")

touch resource$current_time.txt
chmod 755 resource$current_time.txt
date;
date >> resource$current_time.txt


echo " Please refer to resource.txt for memory & cpu utlization."
echo " "
echo " "
echo "Current Memory Utilization is: $mem" >> resource$current_time.txt
echo " "
echo " "
echo "Current CPU Utilization is: $cpu" >> resource$current_time.txt