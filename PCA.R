#Data load
universities<-read.csv("C:\\Users\\poorvee\\Desktop\\Data_Science\\ExcelR\\R_scripts\\New_batch\\24_Apr\\Universities.csv")

pca<-princomp(universities[,2:7], cor = TRUE,scores = TRUE, covmat = NULL)  #we want to know Corerelation between the columns and scores for each column #covmat is Covariance matrix, as we are getting correlation (true) so we don't want covariance (null)
summary(pca) #see Cumulative Proportion values o/p is same like cumulative variance % in slide. till first 4 PCs columns we will get 0.97487386 of data i.e. 97% data 
pca$loadings #we can get weights here
pca$scores #This is tranformed data called scores table which has PCs(columns or Comp.1,Comp.2 etc)# PC1 (1st cell) has values of all columns of 1st row from actual data set #In this tranformed data, no. of columns and rows will be same as no. of col and rows in actual data set

new_data<-pca$scores[,1:4]  #reducing no. of cloumns to 4 i.e. we are choosing 1st 4 PCs out of 6 because till 4th column we are getting Cumulative Proportion of 0.97487386 
#Now this new_data dataset can be used for next algorithms like regression or clustering or asociation rules etc.
#1st usecase of PCA is below
plot(pca$scores[,1:2],col="Blue",cex = 0.2) # here and next line we can find index of universities which are nearby are of same characteristics and which are far are of diff characteristics Ex. 2nd University is diff from other universities
text(pca$scores[,1:2], labels=c(1:25), cex= .7) #cex is text size #text function gives textual info 
#2nd Usecase is PCA can be applied on image in cat_PCA.R