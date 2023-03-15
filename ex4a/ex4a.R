# Execrise 4a
### I want to plot the number of #fatalities, injuries, major injuries,
### minor injuries, and possible injuries in each CRASH_YEAR
setwd("C:/Spring 2023/CRP 558/LA-558")


# Load necessary libraries
library(ggplot2)
library(dplyr)

# Read in the data
crash_data <- read.csv("Crash Data (SOURCE).csv")

# Group the data by CRASH_YEAR and calculate the sum of each injury type
injury_data <- crash_data %>%
  group_by(CRASH_YEAR) %>%
  summarise(
    FATALITIES = sum(FATALITIES),
    INJURIES = sum(INJURIES),
    MAJINJURY = sum(MAJINJURY),
    MININJURY = sum(MININJURY),
    POSSINJURY = sum(POSSINJURY)
  )

# Plot the data using ggplot2
ggplot(injury_data, aes(x = CRASH_YEAR)) +
  geom_line(aes(y = FATALITIES, color = "Fatalities"), size = 1) +
  geom_line(aes(y = INJURIES, color = "Injuries"), size = 1) +
  geom_line(aes(y = MAJINJURY, color = "Major Injuries"), size = 1) +
  geom_line(aes(y = MININJURY, color = "Minor Injuries"), size = 1) +
  geom_line(aes(y = POSSINJURY, color = "Possible Injuries"), size = 1) +
  labs(title = "Iowa Crash Data",
       x = "Year",
       y = "Number of Injuries",
       color = "Injury Type") +
  theme_bw()




# Create a histogram of fatalities, colored by CRASH_YEAR and split by DRUGALCREL

ggplot(crash_data, aes(x = FATALITIES, fill = CRASH_YEAR)) +
  geom_histogram(binwidth = 1, position = "dodge",
                 aes(y = ..density..), color = "white") +
  facet_wrap(~DRUGALCREL) +
  labs(title = "Histogram of Fatalities by DRUGALCREL and CRASH_YEAR",
       x = "Number of Fatalities",
       y = "Density") +
  theme_bw()





