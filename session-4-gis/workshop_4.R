##################################################
## R Workshops
## Workshop 4: GIS
## Date 2023-03-15
## Jonathan Tannen
##################################################


#-------------
# Objectives
#-------------
# 1. Create spatial variables 
# 2. Map data.


# Optional:
# setwd("C:/path/to/my/directory")

opa_df <- read.csv(
  "C://Users/Jonathan Tannen/Downloads/opa_properties_public.csv"
)


# You probably need to install.packages() these first:
library(sf)
library(ggmap)
library(dplyr)
library(ggplot2)
library(ggthemes)

# Task 1: Map point properties

# 1a. Convert opa_df to a spatial dataframe using st_as_sf
opa_df <- opa_df |> 
  st_as_sf(coords = c("lat", "lng"), crs=4326)

# 1b. Make a simple map of 1,000 random properties.


# 1c. Map those properties, using a color for the single-code zoning.


# 1d. Add a basemap using get_map() and ggmap()

bbox <- st_bbox(opa_df)
names(bbox) <- c("left", "bottom", "right", "top")
phila_base <- get_map(bbox, source="stamen", maptype = "toner-lite")

# 1e. That map probably looks odd. Let's reproject the data to Pennsylvania State-Plane South.




# Task 2: Map of Zip Code price per square foot

# 2a. Load Zips

zips <- st_read("data/Zipcodes_Poly.shp")


# 2b. Use dplyr to create a data.frame with 1 row per zip, with the median ppsf.


# 2c. Join that data to the zip codes.


# 2d. Make a map of Zip Codes colored by median price.



# Task 3: Suppose we didn't have ZIP code already. 
# Use st_within to assign properties to zip codes.



# Task 4: Give each property its distance to city hall
cityhall <- st_sfc(st_point(c(-75.1635, 39.9528)), crs=4326)


# Task 4b: Make a scatter plot of property value vs distance to city hall.
