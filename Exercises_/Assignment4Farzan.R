#Create a Leaflet page in R that includes at least 20 markers. The markers should include a popup or a label, and can be a marker, circle or a circle Marker. Due one of the following 

#Create icons as described in https://rstudio.github.io/leaflet/markers.html  

#Add in a control to select from one of five basemaps – do not just copy my code, you can select a few of your own tiles 

#Add the ability to cluster the points when zoomed out 

##create a Leaflet page in R that includes at least 20 markers

library(leaflet)
m <- leaflet() %>%
  setView(lng = -93.648, lat = 42.0267, zoom = 15)  # set the initial view on Iowa State University

# add 20 markers
locations <- data.frame(
  name = paste0("Marker ", 1:20),
  lon = runif(20, -93.662, -93.634),
  lat = runif(20, 42.009, 42.042)
)
m <- addMarkers(map = m, data = locations, ~lon, ~lat, popup = ~name,label = ~name)
m
# create a custom icon
myIcon <- makeIcon(iconUrl = "https://leafletjs.com/examples/custom-icons/leaf-red.png",
                   iconWidth = 38, iconHeight = 95)

# add 20 markers with custom icon
locations <- data.frame(
  name = paste0("Marker ", 1:20),
  lon = runif(20, -93.662, -93.634),
  lat = runif(20, 42.009, 42.042)
)
m <- addMarkers(map = m, data = locations, ~lon, ~lat, popup = ~name, icon = myIcon)

# display the map
m 

m <- leaflet() %>%
  setView(lng = -93.648, lat = 42.0267, zoom = 15)  # set the initial view on Iowa State University

# add 20 markers with custom icon
locations <- data.frame(
  name = paste0("Marker ", 1:20),
  lon = runif(20, -93.662, -93.634),
  lat = runif(20, 42.009, 42.042)
)
myIcon <- makeIcon(iconUrl = "https://leafletjs.com/examples/custom-icons/leaf-red.png",
                   iconWidth = 38, iconHeight = 95)
m <- addMarkers(map = m, data = locations, ~lon, ~lat, popup = ~name, icon = myIcon)
m
# add basemap layers and control
m <- addTiles(map = m, urlTemplate = "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              attribution = "Map data © <a href='https://openstreetmap.org'>OpenStreetMap</a> contributors")
m <- addProviderTiles(map = m, providers$Esri.WorldTopoMap, group = "Esri")
m <- addProviderTiles(map = m, providers$Esri.WorldImagery, group = "Esri")
m <- addProviderTiles(map = m, providers$Stamen.Toner, group = "Stamen")
m <- addProviderTiles(map = m, providers$Stamen.Terrain, group = "Stamen")
m <- addLayersControl(map = m, baseGroups = c("OpenStreetMap", "Esri", "Stamen"),
                      options = layersControlOptions(collapsed = FALSE))

# display the map
m


# 2.Create a Leaflet page in R that includes a chloropleth. Import your shapefile and set the projection as demonstrated. Due two of the following 

# Add a Popup or a label 

# Add a Legend 

# Add an additional layers containing lines or markers. 

# Load required packages
library(leaflet)
library(sp)
library(rgdal)
library(RColorBrewer)

# Set working directory to where shapefile is located
setwd("C:/Spring 2023/CRP 558/LA-558/Assignment4/USA_States_(Generalized)")

# Import shapefile
my_shp <- readOGR(".", "USA_States_Generalized")

# Set projection
my_shp <- spTransform(my_shp, CRS("+proj=longlat +datum=WGS84"))

# Create color palette for chloropleth
mypalette <- colorNumeric(palette = "YlGn", domain = my_shp$POPULATION)

# Create Leaflet map
map4 <- leaflet() %>%
  addTiles() %>%  # Add default OpenStreetMap tiles
  addPolygons(data = my_shp,  # Add polygons from shapefile
              fillColor = mypalette(my_shp$POPULATION),  # Set fill color using palette
              fillOpacity = 0.7,  # Set fill opacity
              color = "#BDBDC3",  # Set border color
              weight = 1,  # Set border weight
              popup = paste("<b>", my_shp$NAME, "</b><br>",  # Set popup contents
                            "Population: ", my_shp$POPULATION)) 
map4
map5<- map4 %>%  # You can customize the popup contents as needed
  addLegend(pal = mypalette, values = my_shp$POPULATION,  # Add legend for chloropleth
            title = "Population", position = "bottomright") %>% 
  # You can customize the legend title and position as needed
  addPolygons(data = my_shp,  # Add polygons from shapefile
              fillColor = mypalette(my_shp$POPULATION),  # Set fill color using palette
              fillOpacity = 0.7,  # Set fill opacity
              color = "#BDBDC3",  # Set border color
              weight = 1,  # Set border weight,
              label = my_shp$NAME)
map5
map6 <- map5 %>%  # Set label contents
  # You can customize the label contents as needed
  addMarkers(lng = -93.6199, lat = 42.0261,  # Add markers for San Francisco
             popup = "Iowa", label = "Lovely Iowa")  # Set popup and label contents
# You can customize the popup and label contents as needed
map6


