##################################################
## R Workshops
## Workshop 1:  Intro to R and dataframes
## Jonathan Tannen
##################################################

#-------------
# Objectives
#-------------
# Learning objectives
# 1. Use R as a calculator
# 2. Create and subset vectors
# 3. Create and subset data frame
# 4. Install packages
# 5. Summarize the dataset

opa_df <- read.csv("C://Users/Jonathan Tannen/Downloads/opa_properties_public.csv")

## Task 1: What happened? Examine the data using head()



## Task 2: Use dim() to answer: 
## (a) How many properties do we have? 
## (b) How many variables on each property do we have?



## Task 3: Using square bracket notation (df[row,column])
## a: Show the first 10 rows of the data.
## b: Show the element in the 20th row and 3rd column.
## c: What was the sale date and price of the 100th property?
## d: Which row has the address ("location") 2001 S 70TH ST ? 
## e: Filter the dataframe to only properties with nonzero taxable land.



## Task 4: Summarise the property values. 
## a: What is the maximum sale price?
## b: How many properties have a sale price of 0? of 1?
## c: What is the median sale price?
## d: What is the median sale price among those with at least $100?
## e: What is the maximum sale price in 19104?
## f: Use hist() to create a simple histogram of log() sale price.
## f2: Can we make this a probability density histogram? Use ?hist




## Task 5: Create some new variables in opa_df.
## a: ppsf, the price per square foot.
## b: has_fireplace, which is 1 if there is at least one fireplace.
## c: full_address, which is "{location}, Philadelphia, PA {zip}"
## d: is_residential, which is 1 if zoning begins with 'R'.




## Task 6: How many of each do we have? (use table()):
## a: building_code_description
## b: ZIP Code



