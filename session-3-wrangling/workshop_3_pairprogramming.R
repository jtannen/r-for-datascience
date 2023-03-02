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

# Goal 2: Can you add gender to this table?

## Goal 3: How would you visualize this?