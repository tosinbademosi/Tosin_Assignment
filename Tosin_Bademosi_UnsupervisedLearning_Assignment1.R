#Import and review data 
#Load the bus data file and inspect it.
bus <- read.csv("/Users/tosinbademosi/Downloads/bus_data.csv")

#a.	Are there any attributes in the dataset that are not useful for analysis or for making predictions?  Why?
  Yes there are attributes that are not  useful for analysis or for making predictions. The category  attribute like dirTag and different
 attributes that corralated with time.These attributes did not help to make predictions about the route of the bus.
 
b.	Do any of the variables appear to be treated as discrete even though they actually represent continuous values? 
  c.	Do any of the variables seem to represent the same data? 
  Yes. All the attributes that specify time are the same.

d.	What do you think the dirTag attribute represents?
  I think this attribute is a categories of the direction of the bus.The function bwlow help to see the unique groups.
  unique(bus$dirTag)
"1_1_var0"  "1_0_var0"  ""          "66_0_var3"
  
  
#2.	Inspect the distributions of attributes and selecting data (10pts)
#a.	Now inspect the distribution of route numbers. Are there any bus routes that should not be included in our 1 bus analysis? If so, remove those.
unique(bus$D.routeTag)
[1]  1 43 NA 66
# remove the bus route that not be included in the bus 1 analysis.
busdata<-bus[!(bus$D.routeTag== 66 | bus$D.routeTag == "NA" |bus$D.routeTag == 43),]
b.	Is there anything else we should filter that is not a complete attribute?
  busdataclean <- na.omit(busdata)
summary(busdataclean)
  
  PAUSE HERE, BRING FORWARD ANY QUESTIONS TO THE CLASS


3.	Selecting attributes to analyze (10pts)
#	Which attributes should be excluded from analysis? 
  These attributes should be excluded: dirTag, epoch, lastTime,local,predictable,secSinceReport,speedKmHr,time,utc
#  Are any of them perfectly correlated?
cor(busdataclean)
ID     VehicleId     Heading          Lat           Lon DRouteTag SecondsPastMidnight
ID                   1.00000000 -0.2613542661  0.07014553  0.040720482 -0.0813530218        NA          0.98327294
VehicleId           -0.26135427  1.0000000000 -0.01111497 -0.005414687  0.0007579708        NA         -0.26334614
Heading              0.07014553 -0.0111149686  1.00000000  0.190485007 -0.2378587204        NA          0.09685655
Lat                  0.04072048 -0.0054146869  0.19048501  1.000000000 -0.8793296486        NA          0.04319819
Lon                 -0.08135302  0.0007579708 -0.23785872 -0.879329649  1.0000000000        NA         -0.09476506
DRouteTag                    NA            NA          NA           NA            NA         1                  NA
SecondsPastMidnight  0.98327294 -0.2633461366  0.09685655  0.043198186 -0.0947650629        NA          1.00000000

  Yes.epoch, lastTime,local,secSinceReport,speedKmHr,time,utc are perfectly correlated.
  
  #Should we include all of those?
  No.
   b.	If you want to ‘label’ points in your analysis with the direction the buses are heading, which attribute do you need?
     i need the following attributes:id,heading,lat,lon,D.routeTag,secondPastMidnight,vehicledId.
   busdataclean<- cbind.data.frame(busdataclean$id,busdataclean$vehicleId,busdataclean$heading,busdataclean$lat,busdataclean$lon,busdataclean$D.routeTag,busdataclean$secondsPastMidnight)
   #change data columns headings
   
   colnames(busdataclean) <- c("ID","VehicleId","Heading","Lat","Lon","DRouteTag","SecondsPastMidnight")
   
  
  PAUSE HERE, BRING FORWARD ANY QUESTIONS TO THE CLASS



4.	Select Data (10pts)
Filter out the rows that have irrelevant or undefined values for dirTag, and those that have any routeTag other than 1.


PAUSE HERE, BRING FORWARD ANY QUESTIONS TO THE CLASS



5.	View the route (15pts)
a.	Choose features that will help you plot the geographic locations of the route on a graph. Save the graph you produce.

plot(busdataclean$Lat,busdataclean$Lon)

b.	How closely does this mesh with the actual bus route? Can you guess what is happening when there are any deviations from the actual route? 
  
  
  
  PAUSE HERE, BRING FORWARD ANY QUESTIONS TO THE CLASS




6.	Bus time and frequency (15pts)
We want to understand when the buses run and their frequency throughout the 24 hour period. 
a.	Plot out the frequency of the bus observations by two hour increments. Save the graph you produce.
#create a histogram
hist(busdataclean$SecondsPastMidnight/3600)


b.	What are the peak periods when the buses run most frequently?
  The bus run most frequently between 4pm and 8pm.
  Hint: You can view the number of rows that appear by time interval, and then you can make the number of different time intervals 12 instead of the default value, representing 2 hour windows.



PAUSE HERE, BRING FORWARD ANY QUESTIONS TO THE CLASS




C. PCA (20pts)
Perform PCA analysis on this data. 

1.	How many principal components account for almost all (about equal to 100%) of the variance? Inspect the components.
Comment on the features that form the primary “ingredients” in each of these principal components
# i need to remove attribute D.routeTag
busdataclean <- busdataclean[,-c(6)]
busdataclean.pca <- prcomp(busdataclean, center = TRUE,scale. = TRUE)
summary(busdataclean.pca)
Importance of components:
  PC1    PC2    PC3    PC4     PC5     PC6
Standard deviation     1.4873 1.3698 0.9537 0.9313 0.34409 0.12697
Proportion of Variance 0.3687 0.3127 0.1516 0.1446 0.01973 0.00269
Cumulative Proportion  0.3687 0.6814 0.8330 0.9776 0.99731 1.00000

. 
2.	In one or two words discuss what the first, second and third principal components represent.  
Discuss why these features dominate the variance.
The first component represent 37% of the variance. 
The second component represent 31% of the variance. The PC3 reprensent the 15% of the variance.

3.	Plot the data as projected onto two principal components. Find a scatter plot that well separates the two direction tags.
Save the plot. 

fviz_pca_var(busdataclean.pca)

fviz_pca_biplot(busdataclean.pca)
You should see that most of the points cluster into two mostly rectangular blocks.
How do you interpret these blocks? How do you interpret the points that lie outside of these blocks? Hint: Remember what you said these principal components represent in the previous question.

