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

ia_counties <- counties("IA")
plot(ia_counties$geometry, main="All 99 County - Iowa")

dm_tracts <- tracts("IA", "Des Moines")
plot(dm_tracts$geometry, , main="Des Moines County - Iowa")

st_tracts <- tracts("IA", "Story County")
plot(st_tracts$geometry,main="Story County - Iowa")
str(st_tracts)


#### First Plot - My second try 

census_api_key("b2981571606707ca6960874ecd1cfa3d8631b0f2", install = TRUE,  overwrite=TRUE)

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
plot(story_hispanic$value,main="Story County - Hispanic")


# Second Plot:

### A second plot from tidyCensus or a plot using the world data and  the idbr package.

# Codes from Professor Seeger:
age10 <- get_decennial(geography = "state",
                       variables = "P013001",
                       year = 2010)
head(age10)

speakOnlyEnglish <- get_acs(
  geography = "state",
  variables = "B16001_002",
  summary_var = "B16001_001",
  year = 2021,
  #geometry = TRUE
)

# install.packages(c("tidycensus", "tidyverse", "idbr"))
library(tidycensus)
library(tidyverse)
library(idbr)

####
lifecycle::last_lifecycle_warnings()

nigeria_pop <- get_idb(
  country = "Nigeria",
  variables = "pop",
  year = 1990:2100
)

ggplot(nigeria_pop, aes(x = year, y = pop)) + 
  geom_line(color = "darkgreen") + 
  theme_minimal() + 
  scale_y_continuous(labels = scales::label_number_si()) + 
  labs(title = "Population of Nigeria",
       subtitle = "1990 to 2100 (projected)",
       x = "Year",
       y = "Population at midyear")
#############
library(dplyr)
female <- idb1('CH', 2050, sex = 'female') %>%
  mutate(SEX = 'Female')
china <- rbind(male, female) %>%
  mutate(abs_pop = abs(POP))
plot_ly(china, x = POP, y = AGE, color = SEX, type = 'bar', orientation = 'h',
        hoverinfo = 'y+text+name', text = abs_pop, colors = c('red', 'gold')) %>%
  layout(bargap = 0.1, barmode = 'overlay',
         xaxis = list(tickmode = 'array', tickvals = c(-10000000, -5000000, 0, 5000000, 10000000),
                      ticktext = c('10M', '5M', '0', '5M', '10M')),
         title = 'Projected population structure of China, 2050')




# Third Plot:

### A third plot using external data from a csv, xlsx, google sheet or even a Github repository – note  shp, json, or GeoJSON files are also allowed 

setwd("C:/Spring 2023/CRP 558/LA-558/Assignment3")
japan_csv<-read.csv("Japan-idbr.csv")

View(japan_csv$Population)


ggplot(japan_csv, aes(x = GROUP ))+
  geom_bar(fill=japan_csv$X..of.Population) +
  labs(x = "Age Group", title = "Japan Population Age Group" )






