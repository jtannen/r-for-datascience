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

opa_df <- read.csv(
  "C://Users/Jonathan Tannen/Downloads/opa_properties_public.csv"
)

## Task 1: What happened? Examine the data using head()

head(opa_df)

View(opa_df)

## Task 2: Use dim() to answer: 
## (a) How many properties do we have? 
## (b) How many variables on each property do we have?

dim(opa_df)

## Task 3: Using square bracket notation (df[row,column])
## a: Show the first 10 rows of the data.
## b: Show the element in the 20th row and 3rd column.
## c: What was the sale date and price of the 100th property?
## d: Which row has the address ("location") 2001 S 70TH ST ? 
## e: Filter the dataframe to only properties with nonzero taxable land.

opa_df[1:10, ]
opa_df[100, "year_built"]
opa_df$year_built[100]
opa_df[100, c("sale_date", "sale_price")]

which(opa_df$location == "1523 S 7TH ST")
opa_df[opa_df$location == "1523 S 7TH ST", ]

opa_df$taxable_land > 0
opa_df_taxable_land <- opa_df[opa_df$taxable_land > 0, ]

## Task 4: Summarise the property values. 
## a: What is the maximum sale price?

max(opa_df$sale_price)
max(opa_df$sale_price, na.rm=TRUE)
?max

which.max(opa_df$sale_price)
opa_df[which.max(opa_df$sale_price), ]

## b: How many properties have a sale price of 0? of 1?
opa_df[opa_df$sale_price == 1, ]

sum(opa_df$sale_price == 1)
sum(opa_df$sale_price == 1, na.rm=TRUE)

## c: What is the median sale price?

median(opa_df$sale_price, na.rm=TRUE)

## d: What is the median sale price among those with at least $100?

median(
  opa_df$sale_price[opa_df$sale_price >= 100], 
  na.rm=TRUE
)

## e: What is the maximum sale price in 19104?

max(
  opa_df$sale_price[opa_df$zip_code == "19104"],
  na.rm=TRUE
)

max(
  opa_df$sale_price[substr(opa_df$zip_code, 1, 5) == "19104"],
  na.rm=TRUE
)

## f: Use hist() to create a simple histogram of log() sale price.
## f2: Can we make this a probability density histogram? Use ?hist

hist(log(opa_df$sale_price))
hist(log10(opa_df$sale_price))
?hist

hist(log10(opa_df$sale_price), freq=FALSE)

## Task 5: Create some new variables in opa_df.
## a: ppsf, the price per square foot.
opa_df$sale_price / opa_df$total_area
opa_df$ppsf <- opa_df$sale_price / opa_df$total_area

## b: has_fireplace, which is 1 if there is at least one fireplace.
opa_df$has_fireplace <- (
  (opa_df$fireplaces >= 1) & !is.na(opa_df$fireplaces)
)

which(is.na(opa_df$has_fireplace))


## c: full_address, which is "{location} Philadelphia PA {zip}"
opa_df$full_address <- paste(
  opa_df$location, 
  " Philadelphia PA",
  opa_df$zip_code
)

opa_df$full_address <- paste(
  opa_df$location, 
  " Philadelphia PA",
  opa_df$zip_code,
  sep=""
)

opa_df$full_address

## d: is_residential, which is 1 if zoning begins with 'R'.




## Task 6: How many of each do we have? (use table()):
## a: building_code_description
## b: ZIP Code

table(opa_df$building_code_description)
description_counts <- sort(table(opa_df$building_code_description))

write.csv(
  t(t(description_counts)),
  file="C:/Users/Jonathan Tannen/Documents/description_counts.csv",
)

