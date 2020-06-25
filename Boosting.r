data("iris")
#Data partition for model building and testing
set.seed(7) #Seed to produce consistent results on multiple runs
inTraininglocal<-createDataPartition(iris$Species,p=.70,list = F) #70% training data points
training<-iris[inTraininglocal,]
testing<-iris[-inTraininglocal,]
#Model Building
model<-C5.0(training$Species~.,data = training,trials=10) #Trials- Boosting parameter #Training model #Trials = 10 i.e we want to build 10 models  
#Generate the model summary
summary(model) #Under "Evaluation on training data (105 cases)" Size is 5 means 5 leaf nodes formed in M0, 3 leaf nodes formed in M1, 6 leaf nodes formed in M2 
               #In M0 1 data point is misclassified, in M1 5 data points are misclassified and so on
               #Boost model has 0% error (this is trained final model) #Boost model is consolidated o/p of each model
#Predict for test data set
pred<-predict.C5.0(model,testing[,-5]) # do predection of 30% dataset as per trained model
a<-table(testing$Species,pred) #getting actual and predicted values of Species
a #confusion matrix is printed as per actual and predicted values of Species
sum(diag(a))/sum(a) #Find Accuracy of the model #Test accuracy is 0.9555 (95%)
plot(model) #Plotting the trained model

