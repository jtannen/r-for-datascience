##################################################
## R Workshops
## Workshop 1 Pair Programming
## Jonathan Tannen
##################################################

acsphilly <- read.csv("C://Users//Jonathan Tannen///Downloads//acs_phila_2015_5yr.csv")


## Task 1: Familiarize yourself with the survey. What types of variables do we have?



## Task 2: 
## a: How many people are in our survey?
## b: How many men and women are in our survey? 
## c: What is the distribution of age in our survey?



## Task 3:
## a: What are the possible values of empstat, and how many of each are there?
## b: What is the median income of the sample?
## c: What is the median income among employed respondents?
## d: Create a new dataframe, named acs_emp that is only the subset that is employed. 



## Task 4:
## a: What are the possible values of raceth?
## b: What is the median income among employed respondents of each race/ethnicity?



## Task 5: 
## Create a histogram of income for the entire population, 
## and then for a subgroup of your choice.



## Task 7: 
## The variable "serial" is an id for each household.
## However, serial numbers get repeated in different years.
## Create a new variable "year_serial" which is the year pasted together with the serial.
## Hint: use the paste() function.



## Task 8: What is the largest household? Who lives inside?


## Household 2011_1042948 shows up a bunch of times! What is it?



## Task 9:
## *Challenge*: How many different households do we have?
## You may end up using unique(), duplicated(), length()



## Task 10: 
## *Challenge*: The variable "perwt" contains the survey weights for each row. 
## Calculate the weighted.mean() of income. How does it compare to the observed mean?
## The help file ?weighted.mean may help.




