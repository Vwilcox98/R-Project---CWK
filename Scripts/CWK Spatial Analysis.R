# Before running the code, install "ggplot2"

#Load the required packages
library(ggplot2)
library(leaflet)
library(lubridate) 

cwk <- read.csv('CWKCumulative2.csv')

cwk$Date <- as.Date(cwk$Date)

cwk$month <- month(ymd(cwk$Date))
cwk$year <- year(ymd(cwk$Date))

#plotting the desity using the log base 10 transformation makes the data more feasible to work with
plot(density(cwk$Result))
plot(density(log10(cwk$Result)))

##this is to help with analysis
## from now on everything will be in logarithmic scale
cwk$lResult <- log10(cwk$Result)


#the following shows the varying results based on the month/location the data was taken
plot(lResult ~ Date, data = cwk)
#the following shows the regression line for the data set
lines(lowess(cwk$Date, cwk$lResult, f=1/3),
      col='red', lwd=2)
#the month does not explain much, though the year does have an effect


#Shows how the results changed based on the inches of rain that had fallen in the 24 hours prior to collection
plot(lResult ~ Rainfall.in.Last.24.hours, data = cwk)
#Shows the trend line for the logResults for the inches of rain fallen in the 24 hours prior to collection
lines(lowess(cwk$Rainfall.in.Last.24.hours, cwk$lResult), col='red')

#cleaning up code
mod <- lm(lResult ~ Tide.Stage, data = cwk)

#shows tide stage does not have a significant impact on result
summary(mod)
anova(mod)

#Cleaning up code
mod <- lm(lResult ~ month + year + Station, data = cwk)
summary(mod)
anova(mod)

mod <- lm(lResult ~ Date + Station, data = cwk)
summary(mod)

mod <- lm(lResult ~ Date + Latitude + Longitude, data = cwk)
summary(mod)

#shows the average log result for each station location
boxplot(lResult ~ Station, data = cwk)

#Plotting the results with just the Station shows how high some areas could be
ggplot(data=cwk, aes(x=Station, y=Result)) + 
    geom_point() +
    ylim(NA, 3000)


#Using the Date and station allow us to see the comparison per count
#This is not very useful with so many dates being used.
(ggplot(data=cwk, aes(x=Station, y=Date)) + 
      geom_point(aes(size =Result)))



#Plotting the results based on the coordinates shows the different in Enterococci levels in different areas
(ggplot(data=cwk, aes(x=Latitude, y=Longitude)) + 
      geom_point(aes(size =Result)))


#Based on the above results, it is clear FB1,HC1, HC2, and CC1 are the areas where Enteroccus numbers are the highest.


install.packages("maps")
install.packages("sp")
install.packages("maptools")
install.packages("rgdal")
install.packages("lattice")
installed.packages("classInt")
library(maps)
library(sp)
library(maptools)
library(rgdal)
library(lattice)



map_data(map, region = "Charleston", exact = FALSE )
        
world = map(database = "Charleston")        
        
 install.packages("rjson")       
library(dplyr)
library(ggplot2)
library(rjson)
library(jsonlite)
library(leaflet)
library(RCurl)      

 # create leaflet map
 CWK_map <- leaflet(cwk)
 CWK_map <- addTiles(water_locations_map)
CWK_map <- addCircleMarkers(water_locations_map, lng = cwk$Longitude,
                                         lat = cwk$Latitude)
#view the map 
water_locations_map
 
#use the results to show different sizes at each location based on results
unique_markers_map_2 <- leaflet(cwk) %>%
   addProviderTiles("CartoDB.Positron") %>%
   addCircleMarkers(
     radius = ~pal(cwk$lResult),
     stroke = FALSE, fillOpacity = 0.5,
     lng = cwk$Longitude, lat = cwk$Latitude,
     label = ~as.character(cwk$lResult)
   )
 
 
 

 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
