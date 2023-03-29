##################################################
## R Workshops
## Workshop 6 Pair Programming
## Date 2023-03-29
## Jonathan Tannen
##################################################

# Optional:
# setwd("C:/path/to/my/directory")

opa_df <- read.csv(
  "C://Users/Jonathan Tannen/Downloads/opa_properties_public.csv"
)

# Task 1: Goal: What are the determinants of sale price?

# 1a. At a high level, what regression should we fit?
# Think carefully about the y-variable. You may want to create a new one.


# 1b. Fit a simple regression of price on two variables. 
# Interpret the results.


# 1c. Create a plot with x-axis=predicted, y-axis=observed.



# 1d. Add a fixed effect term for year.
# Interpret the results. (You may need as.character()).



# 1e. Create a plot with the year fixed effect over time.
# Hint: Use coef() to extract the coefficients, and choose the right ones.


# 1f. Add ZIP Code fixed effects.
# Interpret the results.


# Challenge: Map the zip code fixed effects.

zips <- st_read("path/to/data/Zipcodes_Poly.shp")



# Task 2: Logistic Regression
# Build a predictor of whether a property is owner-occupied.
# (Let's assume a property is when owner-occupied 
#  when location == mailing_street)


# Follow the same steps above to assess the fit.


