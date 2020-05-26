#Data load
mydata1<-read.csv("C:\\Users\\poorvee\\Desktop\\Data_Science\\ExcelR\\R_scripts\\New_batch\\24_Apr\\Universities.csv")

################################
mydata <- scale(mydata1[,2:7]) #scale is normalize the data , to have uniform scales for each column # so that no any value should dominate 

d <- dist(mydata, method = "euclidean") #Computing the distance matrix #Calculating distance bettween each row
d #print the distances between each row. Ex. Distance between Brown(1) and CMU(3) is 3.5430636
fit <- hclust(d, method="average") # Building the algorithm  #hclust is to form hiererical clusters by applying average linkage method here # try with 'centroid'
plot(fit) # display dendogram
clusters <- cutree(fit, k=5) # cut tree into 5 clusters
# draw dendogram with red borders around the 5 clusters 
rect.hclust(fit, k=5, border="red")
#Attach the cluster numbers to each row of dataset
univ_clusters=data.frame('Uni'=mydata1[,1],'Cluster' =clusters)
#View(univ_clusters)
univ_clusters #Here we found that which University is falling under which cluster Ex. Brown, Columbia , Cornell are part of cluster 1
#To summarize if anyone wants to join Brown then they can join other unversties of lcuster1 as well like Columbia , Cornell etc.
