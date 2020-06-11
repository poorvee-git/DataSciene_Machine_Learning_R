data("iris")
install.packages("caret")
install.packages("C50")
library(caret)
library(C50)
set.seed(7) #Seed is used so that data points which we used in training and testing data set will remain same in multiple runs if we run  program again and again
#Below 3 lines We are partitioning the dataset 70%  for training the model and 30% for testing model
inTraininglocal<-createDataPartition(iris$Species,p=.70,list = F)
training<-iris[inTraininglocal,]
testing<-iris[-inTraininglocal,]

#Model Building
model<-C5.0(Species~.,data = training) #Training model
#Generate the model summary
summary(model)
#Predict for test data set
pred<-predict.C5.0(model,testing[,-5]) #-5 as we want to predict last column so removed 5th column # do predection of 30% dataset as per trained model
a<-table(testing$Species,pred) #getting actual and predicted values of Species
a #confusion matrix is printed as per actual and predicted values of Species
sum(diag(a))/sum(a) #Find Accuracy of the model #Test accuracy is 0.9555 (95%)
plot(model) #Plotting the trained model
