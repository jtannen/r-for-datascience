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

setwd("C://Users/Jonathan Tannen/Downloads/")
opa_df <- read.csv(
  "opa_properties_public.csv"
)

opa_df <- read.csv(
  r"(C:\Users\Jonathan Tannen\Downloads\opa_properties_public.csv)"
)

################################
## Task 1: A ggplot histogram
################################

ggplot(
  opa_df, 
  aes(x = year_built)
) + 
  geom_histogram()

ggplot(
  opa_df[opa_df$year_built > 0,], 
  aes(x = year_built)
) + 
  geom_histogram()


## 1a: Change the histogram to be of sale_price

ggplot(
  opa_df, 
  aes(x = sale_price)
) + 
  geom_histogram() +
  scale_x_log10("Log10 of sale_price")


## 1b: Change the bars to have fill = "blue"

ggplot(
  opa_df, 
  aes(x = sale_price)
) + 
  geom_histogram(fill = "blue") +
  scale_x_log10("Log10 of sale_price")


## 1c: Make aesthetic fill have a mapping to zoning.

ggplot(
  opa_df, 
  aes(x = sale_price)
) + 
  geom_histogram(aes(fill = zoning)) +
  scale_x_log10("Log10 of sale_price")


## 1c2: Hmmmm... can we simplify the number of zoning codes?
opa_df$zoning_1 <- substr(opa_df$zoning, 1, 1)

ggplot(
  opa_df, 
  aes(x = sale_price)
) + 
  geom_histogram(aes(fill = zoning_1)) +
  scale_x_log10("Log10 of sale_price") +
  scale_fill_viridis_d()

## 1d: Give it a title and x/y labels.

ggplot(
  opa_df, 
  aes(x = sale_price)
) + 
  geom_histogram(aes(fill = zoning_1)) +
  scale_x_log10() +
  scale_fill_viridis_d() +
  labs(
    title = "Sale Price by Zoning",
    x = "Sale Price (log10)",
    y = "Count of Sales",
    fill = "Zoning (top-level)"
  ) +
  theme_minimal() 

ggsave(filename="my_histogram.png", width=6, height=4)


########################################
## Task 2: A ggplot scatterplot
## Let's make a scatterplot of Price per Square Foot over time.
########################################

opa_df$sale_date <- as.Date(opa_df$sale_date)

opa_df$ppsf <- opa_df$sale_price / opa_df$total_livable_area
opa_df <- dplyr::sample_n(opa_df, 10000)

ggplot(
  opa_df,
  aes(x=sale_date, y=ppsf)
) +
  geom_point()


## 2a: Your plot probably looks terrible. Can we filter out bad data?
ggplot(
  opa_df[opa_df$sale_date <= "2023-02-15", ],
  aes(x=sale_date, y=ppsf)
) +
  geom_point()

opa_df <- opa_df[!is.na(opa_df$ppsf), ]
opa_df <- opa_df[opa_df$total_livable_area > 0, ]
opa_df[opa_df$ppsf > 30000, ]

ggplot(
  opa_df[opa_df$sale_date <= "2023-02-15", ],
  aes(x=sale_date, y=ppsf)
) +
  geom_point()

## 2b: Would a log10 y-axis help?

ggplot(
  opa_df[opa_df$sale_date <= "2023-02-15", ],
  aes(x=sale_date, y=ppsf)
) +
  geom_point() +
  scale_y_log10()



## 2c: Add a geom_smooth()
opa_df <- opa_df[opa_df$ppsf <= 5000, ]

ggplot(
  opa_df[opa_df$sale_date <= "2023-02-15", ],
  aes(x=sale_date, y=ppsf)
) +
  geom_point() +
  geom_smooth()

## 2d: Map the point color to 1-digit zoning.

ggplot(
  opa_df[opa_df$sale_date <= "2023-02-15" & opa_df$sale_date >= "2016-01-01", ],
  aes(x=sale_date, y=ppsf)
) +
  geom_point(aes(color=zoning_1)) +
  geom_smooth()



## 2e: Add a title and x/y labels.


## 2f: Change the theme (maybe theme_minimal()?)


## 2g: Save the plot using ggsave().



