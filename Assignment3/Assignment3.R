---
title: "Assignment 3"
author: "Farzaneh"
date: "`r Sys.Date()`"
output: html_document
---

# Assignment 3 – 4 points Due March 2nd 

# In this assignment you will create three plots/maps/graphics. You can reference examples from the R Graph Gallery or other references you may have found. 

# A plot using variable(s) of choice from TidyCensus 

# A second plot from tidyCensus or a plot using the world data and  the idbr package 

# A third plot using external data from a csv, xlsx, google sheet or even a Github repository – note  shp, json, or GeoJSON files are also allowed 

# A markdown page containing all three plots, and some description text. Note the plots do not have to be related by topic. This is just a collection of sample work. I recommend keeping it simple. 

# For the plots, one must be a map and one must be something other than a map (no tables!). The third plot is your choice. 
library(tidycensus)
library(tidyverse)
library(tigris)


# First Plot

### A plot using variable(s) of choice from TidyCensus

st <- states()
class(st)
plot(st$geometry)
#View(st)
str(st_tracts)

ia_counties <- counties("IA")
plot(ia_counties$geometry, main="All 99 County - Iowa", col="pink")
pink?plot
dm_tracts <- tracts("IA", "Des Moines")
plot(dm_tracts$geometry, , main="Des Moines County - Iowa", col="orange")

st_tracts <- tracts("IA", "Story County")
plot(st_tracts$geometry,main="Story County - Iowa", col='green')



#### First Plot - My best try 


census_api_key("b2981571606707ca6960874ecd1cfa3d8631b0f2", install = TRUE,  overwrite=TRUE)


us_median_age <- get_acs(
  geography = "state",
  variables = "B01002_001",
  style = "jenks",
  year = 2022,
  survey = "acs1",
  geometry = TRUE,
  resolution = "10m"
) %>%
  shift_geometry()

#plot(us_median_age$geometry)

ggplot(data = us_median_age, aes(fill = estimate)) + 
  geom_sf()

us_median_age %>%
  ggplot(aes( fill = estimate)) + 
  geom_sf() + 
  scale_fill_distiller(palette = "RdPu", 
                       direction = 1) + 
  labs(title = "  Median Age by State, 2022",
       caption = "Data source: 2022 1-year ACS, US Census Bureau",
       fill = "ACS Estimate") +
  theme_void()


# First Plot - My Other try 

## ----decennial-------------------------------------------------------------------------
pop20 <- get_decennial(
  geography = "state",
  variables = "P1_001N",
  year = 2020
)


## ----view-decennial--------------------------------------------------------------------
pop20


## ----census-table----------------------------------------------------------------------
table_p2 <- get_decennial(
  geography = "state", 
  table = "P2", 
  year = 2020
)


## ----view-table------------------------------------------------------------------------
table_p2

## ----query-by-state--------------------------------------------------------------------
ia_hispanic <- get_decennial(
  geography = "county", 
  variables = "P2_002N", 
  state = "IA", 
  year = 2020
)


## ----show-query-by-state---------------------------------------------------------------
ia_hispanic


## ----query-by-county-------------------------------------------------------------------
cedar_hispanic <- get_decennial(
  geography = "tract", 
  variables = "P2_002N", 
  state = "IA", 
  county = "Cedar County", 
  year = 2020
)

story_hispanic <- get_decennial(
  geography = "tract", 
  variables = "P2_002N", 
  state = "IA", 
  county = "Story County", 
  year = 2020
)
plot(pop20$value,main="Story County - Hispanic")


# Second Plot:

### Iowa income estimate.

install.packages(c("tidycensus", "tidyverse", "idbr"))
library(tidycensus)
library(tidyverse)
library(idbr)

iowa_income <- get_acs(
  geography = "tract", 
  variables = "B19013_001",
  state = "IOWA", 
  year = 2020,
  geometry = TRUE
)

iowa_income


plot(iowa_income["estimate"], main=("Estimate of Income - Iowa"))


# Third Plot:

### A third plot using external data from a csv, xlsx, google sheet or even a Github repository – note  shp, json, or GeoJSON files are also allowed 

## Flying etiquette

#FiveThirtyEight is a website founded by Statistician and writer Nate Silver to publish results from  opinion poll analysis, politics, economics, and sports blogging. 
#One of the featured articles considers [flying etiquette](https://fivethirtyeight.com/features/airplane-etiquette-recline-seat/). 
#This article is based on data collected by FiveThirtyEight and publicly available on github. Use the code below to read in the data from the survey:

fly <- read.csv("https://raw.githubusercontent.com/fivethirtyeight/data/master/flying-etiquette-survey/flying-etiquette.csv")

fly$Age <- factor(fly$Age, levels=c("18-29", "30-44", "45-60", "> 60", ""))
fly$Household.Income <- factor(fly$Household.Income, levels = c("$0 - $24,999","$25,000 - $49,999", "$50,000 - $99,999", "$100,000 - $149,999", "150000", ""))
fly$Education <- factor(fly$Education, levels = c("Less than high school degree", "High school degree", "Some college or Associate degree", "Bachelor degree",  "Graduate degree", ""))
fly$travel_freq <- fly$How.often.do.you.travel.by.plane.
levels(fly$travel_freq)

freq_order <- c("Never", "Once a year or less", 
                "Once a month or less", 
                "A few times per month", 
                "A few times per week", "Every day") 
fly$travel_freq <- factor(fly$travel_freq, 
                          levels = freq_order)
levels(fly$travel_freq)

ggplot(data = fly, aes(x = travel_freq)) + 
  geom_bar() + coord_flip()

ggplot(data = fly, aes(x = travel_freq)) + 
  geom_bar()

fly_new <- fly[fly$travel_freq!= "Never",]


fly$baby.on.plane <- fly$In.general..is.itrude.to.bring.a.baby.on.a.plane.
levels(fly$baby.on.plane)[1] <- "Not answered"
levels(fly$baby.on.plane)
baby_rude_levels <- levels(fly$baby.on.plane)[c(2, 3, 4, 1)]
fly$baby.on.plane <- factor(fly$baby.on.plane, 
                            levels = baby_rude_levels)


library(ggplot2)
fly$Education = with(fly, factor(Education, levels = rev(levels(Education))))

ggplot(data = fly, aes(x = 1)) + 
  geom_bar(aes(fill=Education), position="fill") + 
  coord_flip() +
  theme(legend.position="bottom") +
  scale_fill_brewer() + 
  xlab("Ratio") 


ggplot(data = fly, aes(x=fly$Gender, fill = `Do.you.have.any.children.under.18.`))+geom_bar()+ facet_wrap(~`baby.on.plane`) 



