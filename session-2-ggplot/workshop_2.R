##################################################
## R Workshops
## Workshop 2:  Intro to ggplot
## Date 2023-02-15
## Jonathan Tannen
##################################################

#-------------
# Objectives
#-------------
# Learning objectives
# 1. Basics of ggplot2

## Load our first package! 
## (You don't need to rerun install.packages in future sessions)
install.packages("ggplot2")
library(ggplot2)

opa_df <- read.csv(
  "C://Users/Jonathan Tannen/Downloads/opa_properties_public.csv"
)

# opa_df <- read.csv(
#   r"(C:\Users\Jonathan Tannen\Downloads\opa_properties_public.csv)"
# )

################################
## Task 1: A ggplot histogram
################################

ggplot(
  opa_df, 
  aes(x = year_built)
) + 
  geom_histogram()


## 1a: Change the histogram to be of sale_price


## 1b: Change the bars to have fill = "blue"


## 1c: Make aesthetic fill have a mapping to zoning.


## 1c2: Hmmmm... can we simplify the number of zoning codes?


## 1d: Give it a title and x/y labels.



########################################
## Task 2: A ggplot scatterplot
## Let's make a scatterplot of Price per Square Foot over time.
########################################

opa_df$sale_date <- as.Date(opa_df$sale_date)


## 2a: Your plot probably looks terrible. Can we filter out bad data?


## 2b: Would a log10 y-axis help?


## 2c: Add a geom_smooth()


## 2d: Map the point color to 1-digit zoning.


## 2e: Add a title and x/y labels.


## 2f: Change the theme (maybe theme_minimal()?)


## 2g: Save the plot using ggsave().



