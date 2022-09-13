#!/bin/bash
# ======================================================================
# SCRIPT NAME: spellcheck.sh
#
# PURPOSE: KuraLabs Bash Scripting Task#2 | This script will read a file and spell check
# the file. Test out misspelled text files.
#
# REVISION HISTORY: N/A
#
# AUTHOR				DATE			DETAILS
# --------------------- --------------- --------------------------------
# Sterling McKinley	 2022-07-23	  Initial version
# ======================================================================

#VARIABLE ASSIGNMENT
list=/home/sterling/Desktop/list.txt

#Install Aspell - an interactive spell checker
echo "Installing Aspell: $(sudo apt install aspell)";
echo "--------------------------------------------"
echo "--------------------------------------------"

#Read & correct misspellings within list file using Aspell
aspell -c $list