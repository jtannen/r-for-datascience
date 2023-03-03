##################################################
## R Workshops
## Workshop 3: Data Wrangling
## Date 2023-03-03
## Jonathan Tannen
##################################################


#-------------
# Objectives
#-------------
# Learning objectives
# 1. Create, summarize, filter, and sort Variables in a data frame.
# 2. Pivot datasets.
# 3. Join datasets.


# Optional:
# setwd("C:/path/to/my/directory")

opa_df <- read.csv(
  "C://Users/Jonathan Tannen/Downloads/opa_properties_public.csv"
)


# You probably need to install.packages() these first:
library(dplyr)
library(tidyr)
library(ggplot2)


## Task 1: Let's make a plot of...
## - median ppsf 
## - of residential properties  
## - by year

## What data will need to go into our plot?

head(opa_df)

opa_residential <- opa_df[substr(opa_df$zoning, 1, 1) == "R", ]
opa_residential$ppsf <- opa_residential$sale_price / opa_residential$total_livable_area

median_price_df <- opa_df |>
  filter(
    substr(zoning, 1, 1) == "R",
    !is.na(total_livable_area),
    total_livable_area > 0,
    sale_price > 100
  ) |>
  mutate(
    ppsf = sale_price / total_livable_area,
    sale_year = substr(sale_date, 1, 4)
  ) |>
  group_by(sale_year) |>
  summarise(
    median_ppsf = median(ppsf),
    n_properties = n()
  )

opa_df <- opa_df |> 
  mutate(sale_year = substr(sale_date, 1, 4)) |>
  left_join(median_price_df, by="sale_year")

ggplot(
  median_price_df, 
  aes(x = sale_year, y = median_ppsf)
) +
  geom_point(
    aes(size = n_properties)
  )

## Task 2: Create a table with the fraction of properties that are commercial
## for each ZIP Code, sorted from most to least.


zip_summary <- opa_df |>
  mutate(
    zoning_1 = substr(zoning, 1, 1)
  ) |>
  group_by(zip_code, zoning_1) |>
  summarise(
    n_properties = n()
  ) |>
  group_by(zip_code) |>
  mutate(
    prop_zip_1 = n_properties / sum(n_properties)
  ) |>
  pivot_wider(
    id_cols = zip_code,
    names_from = zoning_1,
    values_from = c(n_properties, prop_zip_1),
    values_fill = 0
  )


## Task 3: What plot should we make?

# By Zip Code
# Among Residential Properties
# Fraction of properties with Homestead Exemption
# And median market_value
# Scatter plot of that

ggdf <- opa_df |>
  mutate(
    zoning_1 = substr(zoning, 1, 1)
  ) |>
  filter(
    zoning_1 == "R"
  ) |>
  group_by(zip_code) |>
  summarise(
    n_homestead = sum(homestead_exemption > 0),
    median_mv = median(market_value),
    n_properties = n()
  )

ggplot(
  ggdf,
  aes(x = median_mv, y = 100 * n_homestead / n_properties)
) +
  geom_text(
    aes(label = zip_code, size = n_homestead)
  ) +
  theme_minimal()





