#create a Leaflet page in R that includes at least 20 markers

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

# add in a control to select from one of five basemaps


# create a map
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

