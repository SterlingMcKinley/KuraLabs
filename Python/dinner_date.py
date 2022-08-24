#!/usr/local/bin/python
# ======================================================================
# SCRIPT NAME: dinner_date.py
#
# PURPOSE: Python assignment
#
# REVISION HISTORY: N/A
#
# AUTHOR				DATE			DETAILS
# --------------------- --------------- --------------------------------
# Sterling McKinley	 2022-08-24	  Initial version
# ======================================================================
import time

#Variables
restaurant = "MASTRO\'S STEAKHOUSE"
feelings = [ 'horrible', 'bad', 'fair', 'good', ]
app = {'Chips & Spinach Artichoke Dip': 15 , 'Bread & Butter': 0, 'Soup of the Day': 14, 'Caesar Salad': 25, 'Fried Calamari':22 }
main = {'Bone-In Ribeye': 68, 'Chilean Sea Bass': 42, 'King Crab Legs': 70, 'Lamb Chops': 45, ' Blackened Chicken': 39}
    
print ('============================================')
print ("Welcome to "+ restaurant +" ")
print ('============================================')

#Function gets name from user
def get_name():
    print("Who do we have dining this evening?")
    name = input("My name is: ")
    print("\n") 
    print("Hello ", name)
    return name

#Function gets name from user
def get_name2():
    print("Who else do we have dining this evening?")
    name2 = input("Hi My name is: ")
    print("\n")
    print("Nice to meet you ", name2)
    return name2

get_name()
print("\n")
get_name2()
print("\n")

print("Thank you both for choosing to dine at "+ restaurant +" this evening.")
print("\n")

budget = int(input("May I know your budget for this evening? \n>>>>>$"))

if budget > 250:
    appetizer = str(input("Lets begin your order...would you like an appetizer? yes or no \n>>>>>"))
else:
    print("With all due respect, I would like to advise you that the menu selection is expensive. Please keep that in mind.")

if appetizer == '':
    print ("\n Undecided??? No problem, I will give you two more time.")

if appetizer == "yes":
    print ("Ok, here's the appetizer menu... \n ")
    print (app)
    app_option = str(input("Which appetizer would you like? \n>>>>>"))
    if app_option == "Chips & Spinach Artichoke Dip":
        bill1 = -app.get('Chips & Spinach Artichoke Dip')
    elif app_option == "Bread & Butter":
        bill1 = -app.get('Bread & Butter')
        #print(" This will cost " + app2.get('chips'))
    elif app_option == "Soup of the Day":
        bill1 = -app.get('Soup of the Day')
    elif app_option == "Caesar Salad":
        bill1 = -app.get('Caesar Salad')
    elif app_option == "Fried Calamari":
        bill1 = -app.get('Fried Calamari')

if appetizer == "no":
    print ("Ok, No appetizer. Lets proceed to ordering the main course. \n Here are options for the main course... \n" )
    print (main)
    
main_order = input("Are you ready to order the main course? yes or no \n>>>>>")

if main_order == "yes":
    print ("Ok, here's the main course menu... \n ")
    print (main)
    main_option = str(input("Which entree would you like? \n>>>>>"))
    if main_option == "Bone-In Ribeye":
        bill2 = - main.get('Bone-In Ribeye')
    elif main_option == "Chilean Sea Bass":
        bill2 = -main.get('Chilean Sea Bass')
    elif main_option == "King Crab Legs":
        bill2 = -main.get('King Crab Legs')
    elif main_option == "Lamb Chops":
        bill2 = -main.get('Lamb Chops')
    elif main_option == "Blackened Chicken":
        bill2 = -main.get('Blackened Chicken')

print("\n How is the date/dinner going?" )
print (feelings)
date = input("\n >>>>")

if date == 'good':
  datescore = 4
elif date == 'fair':
  datescore = 3
elif date == 'bad':
  datescore = 2
elif date == 'horrible':
  datescore = 1
  

print ("Hi I wanted to inform you that I am going to calculate the final bill. \n" )
finalbill = bill1 + bill2 
time.sleep(2)
if finalbill > 0:
  print('Im sorry to inform you but your card has declined. Please provide another form of payment.')
  exit()
else:
  print("Your final bill is...")
  print(finalbill)
  print("You card went through, the final bill is paid in full.Thank you for dining at "+ restaurant +"." )
  print("")
  print("After this date, you still have the below amount available...")
  print(budget - finalbill)

print ("What are the chances of a 2nd date/dinner?")
if datescore > 2 and main_option == "King Crab Legs" or "Bone-In Ribeye":
    time.sleep(2)
    print ("Let's plan a second date/dinner")
else: 
    print("No second date...Sorry Not Sorry")