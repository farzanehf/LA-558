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

library(leaflet)
library(rgdal)

# Import shapefile and set projection
us_states <- readOGR(dsn = "C:/Spring 2023/CRP 558/LA-558/GisData/States_shapefile", layer = "States_shapefile.shp")
us_states <- spTransform(us_states, CRS("+proj=longlat +datum=WGS84"))

# Create chloropleth map based on population density
pal <- colorNumeric(palette = "Blues", domain = us_states@data$population_density)
leaflet() %>%
  addProviderTiles("CartoDB.Positron") %>%
  addPolygons(data = us_states,
              fillColor = ~pal(population_density),
              fillOpacity = 0.8,
              color = "#b2b2b2",
              weight = 1,
              popup = paste("<b>", us_states$NAME, "</b><br>",
                            "Population Density: ", us_states$population_density)) %>%
  addLegend(pal = pal, values = us_states@data$population_density,
            title = "Population Density (people per sq. mile)",
            position = "bottomright")

