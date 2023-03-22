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
  filter(!is.na(lat)) |>
  st_as_sf(coords = c("lat", "lng"), crs=4326)

# 1b. Make a simple map of 1,000 random properties.

opa_df_sample <- opa_df |> sample_n(1000)

ggplot(opa_df_sample) + geom_sf()

# 1c. Map those properties, using a color for the single-code zoning.
opa_df_sample <- opa_df_sample |>
  mutate(zoning1 = substr(zoning, 1, 1))

ggplot(opa_df_sample) + geom_sf(aes(color=zoning1))


# 1d. Add a basemap using get_map() and ggmap()

bbox <- st_bbox(opa_df)
names(bbox) <- c("left", "bottom", "right", "top")
phila_base <- get_map(bbox, source="stamen", maptype = "toner-lite")

ggmap(
  phila_base,
  base_layer = ggplot(opa_df_sample)
) + 
  geom_sf(aes(color = zoning1)) +
  theme_map() %+replace% 
  theme(legend.position = "right") +
  labs(
    title = "Properties in Philadelphia",
    subtitle = "Sample of 100",
    color = "Zoning"
  )

# 1e. That map probably looks odd. Let's reproject the data to Pennsylvania State-Plane South.

ggplot(opa_df_sample) + 
  geom_sf()

st_crs(opa_df_sample)

opa_df_sample <- opa_df_sample |>
  st_transform(crs = 2272)

ggplot(opa_df_sample) + 
  geom_sf()


# Task 2: Map of Zip Code price per square foot

# 2a. Load Zips

setwd("C:/Users/Jonathan Tannen/Dropbox/Documents/courses/r-for-datascience/session-4-gis/")
zips <- st_read(
  "data/Zipcodes_Poly.shp"
)
zips

ggplot(zips) + geom_sf()

# 2b. Use dplyr to create a data.frame with 1 row per zip, with the median ppsf.
zip_ppsf <- opa_df |>
  as.data.frame() |>
  filter(sale_price > 100, total_area > 10) |>
  mutate(
    zip_code = as.character(zip_code),
    ppsf = sale_price / total_area
  ) |>
  group_by(zip_code) |>
  summarise(
    med_ppsf = median(ppsf, na.rm=TRUE)
  )


  
# 2c. Join that data to the zip codes.
zips <- zips |> 
  left_join(zip_ppsf, by = c("CODE" = "zip_code"))

# 2d. Make a map of Zip Codes colored by median price.

ggplot(zips) + 
  geom_sf(
    aes(fill = med_ppsf),
    alpha=0.8
  ) +
  scale_fill_viridis_c() +
  theme_map() %+replace% 
  theme(legend.position = "right") +
  labs(
    title="Median Price Per SF",
    fill = "Med(PPSF)"
  )

ggmap(
  phila_base,
  base_layer = ggplot(zips)
) + 
  geom_sf(
    aes(fill = med_ppsf),
    alpha=0.8
  ) +
  scale_fill_viridis_c() +
  theme_map() %+replace% 
  theme(legend.position = "right") +
  labs(
    title="Median Price Per SF",
    fill = "Med(PPSF)"
  )
ggsave(filename = "zip_ppsf.png", width=6, height=6)



# Task 3: Suppose we didn't have ZIP code already. 
# Use st_within to assign properties to zip codes.
opa_df <- opa_df |> st_transform(crs=2272)

opa_zips <- opa_df |> st_within(
  st_transform(zips, 2272)
)

opa_df <- opa_df |>
  filter(
    sapply(opa_zips, length) == 1
  )

opa_zips_vec <- unlist(opa_zips)
opa_df <- opa_df |>
  mutate(
    myzip = zips$CODE[opa_zips_vec]
  )

# Task 4: Give each property its distance to city hall
cityhall <- st_sfc(st_point(c(-75.1635, 39.9528)), crs=4326)
st_distance()

# Task 4b: Make a scatter plot of property value vs distance to city hall.
