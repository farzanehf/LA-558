### Assignment #2  LA-558   Farzaneh-Faramarzi
### Farzaneh Faramarzi
### Professor Seeger

library(ggplot2)
library(dplyr)
library(maptools)
library(tidyverse)
library(maps)
library(mapdata)

library(usmap)
library(usmapdata) #I did not seem to need this library, but add just in case!
library(ggplot2)
setwd("C:/Spring 2023/CRP 558/LA-558/GisData")
USAwindmill = read_csv("USAWindturbinesMapping.csv")
IAwindmill = read_csv("IOWAWindturbinesMapping.csv")
IAwindmill<-data.frame(IAwindmill)
ggplot(IAwindmill, aes(map_id = IAwindmill$t_county ))+geom_map()
#USAstates = ("C:/Spring 2023/CRP 558/LA-558/GisData/States_shapefile/States_shapefile.shp")
library(usmap)
library(ggplot2)

#Blank US state map
usmap::plot_usmap()

# US county map
usmap::plot_usmap(regions = "states")
df <- usmap::us_map()
IAwindmill <= list(IAwindmill)

windmill_iowa <- ppp(df$x,y=df$y , poly=list(x = IAwindmill$xlong, IAwindmill$ylat))
plot(windmill_iowa,pch=19,main='')

ggplot(IAwindmill, aes(IAwindmill["t_state"]))+geom_map()

#Raw map data
#The raw US map data for counties or states can be obtained for further 
#manipulation (and joining with data). The default regions is "states".
states_df <- usmap::us_map()
counties_df <- usmap::us_map(regions = "counties")
### Map 1 is showing windmills location in the entire USA 
ggplot(states_df, aes(full)) +labs(title = "Counties Populations")+fill(states_df["group"])+geom_bar()

qplot(va)


# Map 2 
```{r}
#install.packages(c("gpclib","maptools"))
library("gpclib")
library("maptools")
setwd("C:/Spring 2023/CRP 558/LA-558/GisData/London")
London_shp = readShapePoly("LDNSuicides.shp")
London_csv<-read.csv("london.csv")
plot(London_shp)


London_shp$ID1=row.names(London_shp)
London_csv$ID2=row.names(London_csv)
shp.csv=merge(London_shp, London_csv, by.x = "ID1", by.y = "ID2")
s = spplot(shp.csv, zcol="logSMR",col=NA) 
s

s+ labs(title = "London Map",subtitle = "These are the boroughs of the London"))

# Map 3

Ames <- read.csv("Ameshousing.csv")
head(Ames)
library(ggplot2)
lm(SalePrice ~ LivingArea, data = Ames)
ggplot(Ames, aes(x = LivingArea,  y = SalePrice))+
  geom_point(col="green")+
  geom_smooth()+
  labs(x = "living area", y = "sale proce", title = "sale price vs living area")

# Map 4

towns <- read.csv("towns2.csv")
dim(towns)
str(towns)
head(towns)
towns$ames <- 0
towns$ames[52] <- 1
library(ggplot2)
library(reshape2)

towns.melt <- melt(towns, id.vars = c(1, 14), measure.vars = 4:5)
qplot(value, Score, data = towns.melt, geom = "point") +
  facet_wrap(~ variable) +
  labs(x = "value")

ggplot(towns.melt,aes(value))+
  geom_bar(width=0.7,col="red")+
  labs(fill = towns.melt$variable, title = "Selected South America countries", ) +
  coord_flip()


```
