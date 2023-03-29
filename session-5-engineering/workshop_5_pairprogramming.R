##################################################
## R Workshops
## Workshop 5 Pair Programming
## Date 2023-03-22
## Jonathan Tannen
##################################################


## We'll use tigris and tidycensus to load census data:

library(tigris)
library(tidycensus)
library(ggplot2)
library(dplyr)
library(tidyr)

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

calc_percent <- function(
    numerator, 
    denominator=phila_census$pop_total
){
  return(
    100 * numerator / denominator
  )
}
  
  
# phila_census$pct_wnh <- 100 * phila_census$pop_wnh / phila_census$pop_total
# phila_census$pct_bnh <- 100 * phila_census$pop_bnh / phila_census$pop_total
# phila_census$pct_aian <- 100 * phila_census$pop_aian / phila_census$pop_total
# phila_census$pct_a <- 100 * phila_census$pop_aian / phila_census$pop_total
# phila_census$pct_aipi <- 100 * phila_census$pop_aipi / phila_census$pop_total
# phila_census$pct_hisp <- 100 * phila_census$pop_hisp / phila_census$pop_total

phila_census$pct_wnh <- calc_percent(phila_census$pop_wnh)
phila_census$pct_bnh <- calc_percent(phila_census$pop_bnh)
phila_census$pct_a <- calc_percent(phila_census$pop_a)
phila_census$pct_aian <- calc_percent(phila_census$pop_aian)
phila_census$pct_aipi <- calc_percent(phila_census$pop_aipi)
phila_census$pct_hisp <- calc_percent(phila_census$pop_hisp)

phila_census <- phila_census |> mutate(
  pct = across(
    c(pop_wnh, pop_bnh, pop_aian, pop_a, pop_aipi, pop_hisp),
    calc_percent
  )
)

cut_percent <- function(pct_col){
  return(
    cut(
      pct_col, 
      breaks = c(0, 10, 20, 50, 75, 100), 
      include.lowest=TRUE
    )
  )
}


phila_census$q_wnh <- cut_percent(phila_census$pct_wnh)
phila_census$q_bnh <- cut_percent(phila_census$pct_bnh)
phila_census$q_aian <- cut_percent(phila_census$pct_aian)
phila_census$q_a <- cut_percent(phila_census$pct_a)
phila_census$q_aipi <- cut_percent(phila_census$pct_aipi)
phila_census$q_hisp <- cut_percent(phila_census$pct_hisp)



# phila_census$q_bnh <- cut(phila_census$pct_bnh, breaks = c(0, 10, 20, 50, 100))
# phila_census$q_aian <- cut(phila_census$pct_aian, breaks = c(0, 10, 20, 50, 100))
# phila_census$q_a <- cut(phila_census$pct_aian, breaks = c(0, 10, 20, 50, 100))
# phila_census$q_aipi <- cut(phila_census$pct_aipi, breaks = c(0, 10, 20, 50, 100))
# phila_census$q_hisp <- cut(phila_census$pct_hisp, breaks = c(0, 10, 20, 50, 100))

library(sf)
zips <- st_read("C:/Users/Jonathan Tannen/Dropbox/Documents/courses/r-for-datascience/session-4-gis/data/Zipcodes_Poly.shp")

ZIP_CODE <- "19104"

# phila_census2 <- phila_census[
#   phila_census$GEOID %in% phila_tracts$GEOID[st_intersects(phila_tracts, zips |> st_transform(st_crs(phila_tracts)) |> filter(CODE == ZIP_CODE)) |> sapply(function(x) length(x) > 0)|> which()],
# ]

my_zip <- zips |> 
  st_transform(st_crs(phila_tracts)) |> 
  filter(CODE == ZIP_CODE)

tract_is_in_zip <- st_intersects(phila_tracts, my_zip) |> 
    sapply(function(x) length(x) > 0)

geoids_in_zip <- phila_tracts$GEOID[tract_is_in_zip]

phila_census$is_in_zip <- phila_census$GEOID %in% geoids_in_zip



ggplot(
  phila_tracts |> inner_join(phila_census2, by="GEOID")
) +
  geom_sf(aes(fill = q_wnh)) +
  scale_fill_brewer() +
  labs(
    title = paste("Percent wnh in", ZIP_CODE, "tracts")
  )

ggplot(
  phila_tracts |> inner_join(phila_census2, by="GEOID")
) +
  geom_sf(aes(fill = q_bnh)) +
  scale_fill_brewer() +
  labs(
    title = paste("Percent bnh in 19104 tracts")
  )

ggplot(
  phila_tracts |> inner_join(phila_census2, by="GEOID")
) +
  geom_sf(aes(fill = q_a)) +
  scale_fill_brewer() +
  labs(
    title = paste("Percent a in 19104 tracts")
  )
