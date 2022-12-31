##################################################
## R Workshops
## Workshop 1 Pair Programming
## Jonathan Tannen
##################################################

acsphilly <- read.csv("C://Users//Jonathan Tannen///Downloads//acsphilly.csv")

## Task 1: Familiarize yourself with the survey. What types of variables do we have?
head(acsphilly)
summary(acsphilly)



## Task 2: 
## a: How many people are in our survey?
## b: How many men and women are in our survey? 
## c: What is the distribution of age in our survey?
nrow(acsphilly)
table(acsphilly$sex)
summary(acsphilly$age)
hist(acsphilly$age)


## Task 3:
## a: What are the possible values of empstat, and how many of each are there?
## b: What is the median income of the sample?  (use median())
## c: What is the median income among employed respondents?
## d: Create a new dataframe, named acs_emp that is only the subset that is employed. 
table(acsphilly$empstat)
median(acsphilly$incwage)
median(acsphilly$incwage[acsphilly$empstat == "Employed"])
acs_emp <- acsphilly[acsphilly$empstat == "Employed", ]


## Task 4:
## a: What are the possible values of raceth?
## b: What is the median income among employed respondents of each race/ethnicity?
table(acsphilly$raceth)
median(acs_emp$incwage[acs_emp$raceth == "A-NH"])
by(acs_emp$incwage, acs_emp$raceth, median)



## Task 5: 
## Create a histogram of income for the entire population, 
## and then by a sub-category of your choice
hist(acsphilly$incwage)
hist(acsphilly$incwage[acsphilly$sex == "Female"])



## Task 7: 
## The variable "serial" is an id for each household.
## However, serial numbers get repeated in different years.
## Create a new variable "year_serial" which is the year pasted together with the serial.
## Hint: Look up how to use the paste() function.
acsphilly$year_serial = paste(acsphilly$year, acsphilly$serial, sep = "_")



## Task 8: What is the largest household? Who lives inside?
which.max(table(acsphilly$year_serial))

## Household 2011_1042948 shows up 1270 times! (??)

acsphilly[acsphilly$year_serial == '2011_1042948',]
## (oh... what is it?)


## Task 9:
## *Challenge*: How many different households do we have?
## You may end up using unique(), duplicated(), length()
length(unique(acsphilly$year_serial))


## Task 10: 
## *Challenge*: The variable "perwt" contains the survey weights for each row. 
## Calculate the weighted.mean() of income. How does it compare to the observed mean?
## The help file ?weighted.mean may help.
mean(acs_emp$incwage)
weighted.mean(acs_emp$incwage, w = acs_emp$perwt)


## Task 11: 
## Big Question: Is there evidence of a different return to education for men and women?
## To answer this, compare the difference in incomes for highly-educated and less-educated women, 
## to the difference for men.

mean(acs_emp$incwage[acs_emp$educ == "4 years of college" & acs_emp$sex == "Male"])
mean(acs_emp$incwage[acs_emp$educ == "4 years of college" & acs_emp$sex == "Female"])

mean(acs_emp$incwage[acs_emp$educ == "Grade 12" & acs_emp$sex == "Male"])
mean(acs_emp$incwage[acs_emp$educ == "Grade 12" & acs_emp$sex == "Female"])
