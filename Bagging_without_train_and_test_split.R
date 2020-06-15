library(ipred) #ipred library will be used 
set.seed(300) #Seed to produce consistent results on multiple runs
mybag <- bagging(iris$Species ~ ., data = iris, nbagg = 50) #nbagg = 50 i.e. we want to create 50 models i.e. 50 times same data is sampled to create 50 models
#summary(mybag) #no need to see summary here
credit_pred <- predict(mybag, iris[,-5]) #-5 as we want to predict last column so removed 5th column
result<-table(credit_pred, iris$Species) #getting actual and predicted values of Species #full iris data set we have used to train (mybag) and full iris data set used to test
result #confusion matrix is printed as per actual and predicted values of Species . Here we see 17 classified correctly and 3 classified incorrectly # Here we see 2X3 matrix 
sum(diag(result))/sum(result) #Find Accuracy of the model #This will give 100% accuracy as we have not divided iris dataset into train and test, full iris data set we have used to train (mybag) and full iris data set used to test
#plot(mybag) #Plotting the trained model #Plotting will fail

