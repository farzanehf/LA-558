### Assignment #2  LA-558   Farzaneh-Faramarzi
### Farzaneh Faramarzi
### Professor Seeger

library(ggplot2)
library(dplyr)
library(maptools)
library(tidyverse)
library(maps)
library(mapdata)


setwd("C:/Spring 2023/CRP 558/LA-558/GisData")
tornado <- read.csv('tornado.csv', as.is=T)
iowa <- read.csv('ia.csv', as.is=T)

#### First Map

tornado_ppp <- ppp(tornado$x, tornado$y, poly=list(x = iowa$x, y=iowa$y))
plot(tornado_ppp,pch=17,main='')


#### Second Map

library("gpclib")
library("maptools")
setwd("C:/Spring 2022/Stat 576/HW #3/London/London")
London_shp = readShapePoly("LDNSuicides.shp")
London_csv<-read.csv("london.csv")
plot(London_shp)


London_shp$ID1=row.names(London_shp)
London_csv$ID2=row.names(London_csv)
shp.csv=merge(London_shp, London_csv, by.x = "ID1", by.y = "ID2")
spplot(shp.csv, zcol="logSMR",col=NA)
