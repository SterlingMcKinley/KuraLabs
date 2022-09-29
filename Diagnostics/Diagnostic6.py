#!/usr/bin/python
# ===========================================================================
# SCRIPT NAME: Diagnostic6.py
#
# Description: This script was part of Diagnostic 6. This script will: 
#               1- open an external file (grades.txt)
#               2- return specific data
#               3- create/write to different files based on the returned data    
#
# REVISION HISTORY: N/A
#
# AUTHOR		   DATE			DETAILS
# --------------------- --------------- -------------------------------------
# Sterling McKinley	 2022-08-29	  Initial version
# ===========================================================================
learnerGrades = open('grades.txt', 'r')
for line in learnerGrades:
    line_split = line.split()
    if "fail" in line_split:
        print(line_split)
learnerGrades.close()

learnerGrades = open('grades.txt', 'r')
for line in learnerGrades:
    line_split = line.split()
    if line_split[2] == 'fail':
        print(line_split)
learnerGrades.close()