##################################################
## R Workshops
## Workshop 2 Pair Programming
## Jonathan Tannen
##################################################

acsphilly <- read.csv(r"(C:\Users\Jonathan Tannen\Downloads\acs_phila_2015_5yr.csv)")

###########################
## Task 1: Histogram of wages
###########################

# 1a: Make a histogram of wages


# 1b: Replace the geom_histogram with a geom_freqpoly
acsphilly_copy <- acsphilly
acsphilly_copy$sex <- "Total"

ggdf <- rbind(
  acsphilly,
  acsphilly_copy
)

ggplot(ggdf, aes(x=incwage))+
  geom_freqpoly(aes(color=sex)) +
  annotate("text", x=1e3, y=20e3, label="Total", hjust=0)

# 1c: Add information about `sex` to the plot.
# Consider using the aesthetic "color".


# 1d: Use `+ facet_wrap(~race)` to facet this plot by race.


# 1e: Add a title, x/y labels, and a better theme.


###################################
# Task 2: Scatterplot of Income by Age
###################################

ggplot(
  acsphilly,
  aes(x=age, y=incwage, color=sex)
) +
  geom_point(alpha = 0.01) +
  geom_smooth() +
  scale_color_manual(
    values=c(Female = "red", Male = "black")
  )

library(scales)
ggplot(
  acsphilly,
  aes(x=age, y=incwage, color=sex)
) +
  geom_point(alpha = 0.01) +
  geom_smooth() +
  scale_color_discrete(
    type=c("skyblue", "orange")
  ) +
  scale_y_continuous(labels=comma) +
  facet_grid(
    edlab  ~ raceth
  )
 
# 1a: Make a scatterplot of income by age.


# 1b: Add a geom_smooth()


# 1c: Add information about `sex`


# 1d: Maybe make the points more transparent? (set alpha=0.1)


# 1e: Add an interesting facet.


# 1f: Challenge: make the plot better by (with the help files) 
# - tweaking the yscale (scale_y_continuous())
# - changing the limits (coord_cartesian())
# - something else?

