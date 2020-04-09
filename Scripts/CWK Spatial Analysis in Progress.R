# Before running the code, install "ggplot2"

#Load the required packages
library(ggplot2)


#Plotting the results with just the Station shows how high some areas could be
ggplot(data=CWKCumulative2, aes(x=Station, y=Result)) + 
    geom_point() +
    ylim(NA, 3000)


#Using the Date and station allow us to see the comparison per count
#This is not very useful with so many dates being used.
(ggplot(data=CWKCumulative2, aes(x=Station, y=Date)) + 
      geom_point(aes(size =Result)))



#Plotting the results based on the coordinates shows the different in Enterococci levels in different areas
(ggplot(data=CWKCumulative2, aes(x=Latitude, y=Longitude)) + 
      geom_point(aes(size =Result)))


# Based on the above results, it is clear FB1,HC1, HC2, and CC1 are the areas where Enteroccus numbers are the highest.





