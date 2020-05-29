#Data load
Universities<-read.csv("C:\\Users\\poorvee\\Desktop\\Data_Science\\ExcelR\\R_scripts\\New_batch\\24_Apr\\Universities.csv")

################################
# Elbow method
install.packages('factoextra')
library(factoextra)
#Make the plot by using fviz_nbclust function via kmeans clustering with wss method (elbow method) to find optimal number of clusters 
fviz_nbclust(Universities[,-1], kmeans, method = "wss") +
  labs(subtitle = "Elbow method") #-1 is used to remove 1st column i.e. Name. labs function is used to give subtitle to the plot

###Cluster algorithm building
km <- kmeans(Universities[,-1],4) #after 4th data point slope is almost flat so forming 4 clusters #K-means clustering with 4 clusters #after deciding 4 cluster count , based on the distance of data points to centroid, 4 clusters will be formed.
km
km$centers # 1275.000 is average of SAT score of all the rows(data points) which fall under cluster1
km$cluster #shows which unversity falls under which cluster
##Animation
install.packages("animation")
library(animation)
windows()  #just to open animation window
km <- kmeans.ani(Universities[,-1], 4)
