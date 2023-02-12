##################################################
## R Workshops
## Workshop 1 Pair Programming
## Jonathan Tannen
##################################################

acsphilly <- read.csv("C://Users//Jonathan Tannen///Downloads//acs_phila_2015_5yr.csv")


## Task 1: Familiarize yourself with the survey. What variables do we have?



## Task 2: 
## a: How many people are in our survey?
## b: How many men and women are in our survey? 
## c: What is the distribution of age in our survey?



## Task 3:
## a: What are the possible values of empstat, and how many of each are there?
## b: What is the median income of the sample?
## c: What is the median income among employed respondents?
## d: Create a new dataframe, named acs_emp that is only the subset that is employed. 

acs_emp <- acsphilly[
  acsphilly$empstat == "Employed" & !is.na(acsphilly$empstat), 
]


## Task 4:
## a: What are the possible values of raceth?
## b: What is the median income among employed respondents of each race/ethnicity?

median(
  acsphilly$incwage[acsphilly$raceth == "B-NH" & acsphilly$empstat == "Employed"]
)

median(
  acs_emp$incwage[acsphilly$raceth == "B-NH"],
  na.rm=TRUE
)

median(acs_emp$incwage[acsphilly$raceth == "Hispanic"], na.rm=TRUE)


for(re in c("B-NH", "W-NH", "Hispanic")){
  print(re)
  print(
    median(
      acs_emp$incwage[acs_emp$raceth == re],
      na.rm=TRUE
    )
  )
}

library(dplyr)

acsphilly %>% filter(empstat=="Employed") %>% group_by(raceth) %>% summarise(median(incwage))

## Task 5: 
## Create a histogram of income for the entire population, 
## and then for a subgroup of your choice. (Hint: Consider "hist()")



## Task 6: 
## The variable "serial" is an id for each household.
## However, serial numbers get repeated in different years.
## Create a new variable "year_serial" which is the year pasted together with the serial.
## Hint: use the paste() function.



## Task 7: What is the largest household? Who lives inside it?


## Household 2011_1042948 shows up a bunch of times! What is it?



## Task 8:
## *Challenge*: How many different households do we have?
## You may end up using unique(), duplicated(), length()



## Task 9: 
## *Challenge*: The variable "perwt" contains the survey weights for each row. 
## Calculate the weighted.mean() of income. How does it compare to the observed mean?
## The help file ?weighted.mean may help.




