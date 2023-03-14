# Excercise 7b 
# Create a simple Leaflet map in R of a point and add it to your GitHub page. Use example provided in the lecture 
## Leaflet map in R with a point at Herman Park in Houston, Texas
install.packages("leaflet", "tidycensus", "tidyverse", "plotly")

# load required libraries
library(leaflet)
library(tidycensus)
library(tidyverse)
library(readxl)
# define coordinates for Herman Park in Houston-TX
lat <- 29.7214
lng <- -95.3871


# Set value for the minZoom and maxZoom settings.
leaflet(options = leafletOptions(minZoom = 0, maxZoom = 2))

# create a Leaflet map centered on Herman Park
map <- leaflet() %>%
  addTiles() %>%  
  addMarkers(lng= -95.3871, lat=29.7214, popup="Herman Park my favorite park")
map  # Print the map

map %>% setView(lng= -95.3871, lat=29.7214, zoom = 15)
