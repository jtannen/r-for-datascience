##################################################
## R Workshops
## Workshop 3 Pair Programming
## Date 2023-03-03
## Jonathan Tannen
##################################################

acsphilly <- read.csv(r"(C:\Users\Jonathan Tannen\Downloads\acs_phila_2015_5yr.csv)")

###########################
## Wage by Education
###########################

library(dplyr)
library(ggplot2)
library(tidyr)

# Goal: Make a bar chart of median wage (incwage), by education (edlab),
# among people with empstat "Employed".

# Hint: What will your dataset need to look like before you ggplot it?


# Plot tip 1: For your bar geom, you probably want stat="identity"
# Plot tip 2: To control the order of edlab, you will need to replace it with a 
# factor(), and set the levels=...


###################################
# Education by Race
###################################

# Goal: Make a table with the percent of educational attainment (edlab) by 
# raceeth.

ggdf_race <- acsphilly |>
  group_by(raceth, edlab) |>
  summarise(
    n_education = n()
  ) |>
  group_by(raceth) |>
  mutate(
    denominator = sum(n_education),
    educ_percent = n_education / sum(n_education) * 100,
    edlab = factor(
      edlab, 
      levels = c(
        "<HS",
        "HS/GED",
        "Some College",
        "Associate's",
        "Bachelor's",
        "Master's",
        "Professional",
        "Doctorate"
      )
    )
  )

# Goal 2: Can you add gender to this table?

ggdf_race_gender <- acsphilly |>
  group_by(raceth, sex, edlab) |>
  summarise(
    n_education = n()
  ) |>
  group_by(raceth, sex) |>
  mutate(
    denominator = sum(n_education),
    educ_percent = n_education / sum(n_education) * 100,
    edlab = factor(
      edlab, 
      levels = c(
        "<HS",
        "HS/GED",
        "Some College",
        "Associate's",
        "Bachelor's",
        "Master's",
        "Professional",
        "Doctorate"
      )
    )
  )


# Goal 3: How would you visualize this?
ggplot(
  ggdf_race,
  aes(x=raceth, y=educ_percent)
) +
  geom_bar(aes(fill = edlab), color="black", stat="identity")

ggplot(
  ggdf_race_gender,
  aes(x=raceth, y=educ_percent)
) +
  geom_bar(aes(fill = edlab), color="black", stat="identity") +
  facet_grid(~sex)

ggplot(
  ggdf_race_gender,
  aes(x=interaction(sex, raceth, sep = "\n"), y=educ_percent)
) +
  geom_bar(
    aes(fill = edlab), 
    color="black", 
    stat="identity"
  ) +
  labs(
    fill = "Education",
    x = "Race x Gender",
    y = "% of group"
  )

ggplot(
  ggdf_race_gender,
  aes(x=edlab, y=educ_percent)
) +
  geom_bar(
    aes(fill = sex), 
    color="black", 
    stat="identity",
    position="dodge"
  ) +
  facet_wrap(~raceth)

ggdf_race_gender |>
  filter(raceth == "AI-NH", edlab == "Associate's")
