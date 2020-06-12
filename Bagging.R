library(ipred) #ipred library will be used 
set.seed(300) #Seed to produce consistent results on multiple runs
train<-iris[1:130,]  #As of now dividing the model not randomly 
test<-iris[131:150,]
mybag <- bagging(train$Species ~ ., data = train, nbagg = 50) #nbagg = 50 i.e. we want to create 50 models i.e. 50 times same data is sampled to create 50 models #CART method is used in bagging 
#summary(mybag) #no need to see summary here
credit_pred <- predict(mybag, test[,-5]) #-5 as we want to predict last column so removed 5th column
result<-table(credit_pred, test$Species) #getting actual and predicted values of Species
result #confusion matrix is printed as per actual and predicted values of Species . Here we see 17 classified correctly and 3 classified incorrectly # Here we see 2X3 matrix 
#sum(diag(result))/sum(result) #Find Accuracy of the model #This formula won't give correct accuracy as it is not symmetric matrix currently it is 2X3 matrix. Matrix should be 2X2 or 3X3 to use this formula 
#so we can clculate accuracy like 17/20 = 0.85 (85% is accuracy)
#plot(mybag) #Plotting the trained model #Plotting will fail

