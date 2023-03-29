##################################################
## R Workshops
## Workshop 6: Regression
## Date 2023-03-29
## Jonathan Tannen
##################################################


#-------------
# Objectives
#-------------
# 1. Fit regressions in R. 
# 2. Navigate the results

# install.packages("titanic", "stargazer")

library(titanic)
library(stargazer)
data("titanic_train")

## We will be trying to predict who survived on the Titanic.

## Task 1: Use summary to look at the structure of titanic_train


## Task 2: What was the survival probability among men and women?


## Task 3: Plot the survival by age


## Task 4: use lm to fit a linear regression of Survived on Age.
## Interpret the results.


## Task 4b: Use str() to see what the fit object contains.


## Task 5: Use glm to fit a logistic regression.


## Task 6: Use predict() to store the predictions to the dataframe. 


## Task 9: Add Sex to the regression. Interpret the results.


## Task 10: Interact sex with age. Interpret the results.


## Task 11: Predict the probabilities of survival.
## Plot the results.


## Task 12: Use stargazer to save the table for publication.



