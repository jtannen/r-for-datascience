##################################################
## R Workshops
## Workshop 4 Pair Programming
## Date 2023-03-15
## Jonathan Tannen
##################################################


## We'll use tigris and tidycensus to load census data:

library(tigris)
library(tidycensus)

# request a key at http://api.census.gov/data/key_signup.html
census_api_key("YOUR_KEY_HERE")

phila_tracts <- tracts(state = 42, county=101)

phila_census <- get_decennial(
  geography = "tract",
  variables = c(
    h_units = "H1_001N",
    h_occ = "H1_002N",
    h_vac = "H1_003N",
    pop_total = "P2_001N",
    pop_wnh = "P2_005N",
    pop_bnh = "P2_006N",
    pop_aian = "P2_007N",
    pop_a = "P2_008N",
    pop_aipi = "P2_009N",
    pop_hisp = "P2_002N"
  ),
  year = 2020,
  state=42,
  county=101,
  output="wide"
)

phila_acs <- get_acs(
  geography = "tract",
  variables = c(medinc = "B19013_001"),
  year = 2020,
  state=42,
  county=101,
  output="wide"
)

phila_census



# Task 1: Make a map of race & ethnicity by Census tract.
# Hint: You will need to...
# - Join the dataframes
# - Create the necessary variables.
# - Pivot or filter the data to get what you need.

# Map the White NH proportion

phila_census <- phila_census |>
  mutate(
    prop_wnh = pop_wnh / pop_total 
  )

ggtracts <- phila_tracts |>
  left_join(phila_census, by="GEOID")

ggplot(ggtracts) + 
  geom_sf(aes(fill = prop_wnh))

library(tidyr)
ggtracts <- phila_tracts |>
  left_join(phila_census, by="GEOID") |>
  pivot_longer(pop_wnh:pop_hisp, names_to = "raceth") |>
  mutate(
    prop = value / pop_total,
    race_label = case_when(
      raceth == "pop_a" ~ "Asian",
      raceth == "pop_aian" ~ "AI/AN",
      TRUE ~ "Default Value"
    )
  )

ggplot(ggtracts) + 
  geom_sf(aes(fill = prop)) +
  facet_wrap(~raceth) +
  theme_map() %+replace%
  theme(legend.position = "right")


# Task 1b: What projection are the census tracts using? 
# What range is that optimized for? (use google)
# Can you use a better projection?




# Task 2: Create a scatter plot of median home sales price by median income.
# Hint: You will need to...
# - Assign each opa data to a Census Tract.
# - Group by tract to calculate a median price.
# - Join the dataframes.




