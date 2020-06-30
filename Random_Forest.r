install.packages("randomForest")
library(randomForest)
#Here in this example we are not splitting the data set to train and test but still randomForest will split input data into train and test
model<-randomForest(iris$Species~.,data=iris,ntree=1000) #Building 1000 trees
# View the forest results.
print(model) #OOB estimate of error rate is out of bag error for datapoints which will be used for testing and what we get error in that. #OOB error is consolidated error from all trees (testing data points of all trees) so Testing error 4%
#We need to see confusion matrix for the model as well because within the model itself data is splitted into train and test.
#Imoporantce of the variable - Lower Gini
print(importance(model)) #more the value more the reduced impurity, petal width is best column then Petal length is best column
#Prediction
pred<- predict(model,iris[,-5]) #Here we are predicting for full data. 
a<-table(pred,iris$Species) #getting actual and predicted values of Species
a #confusion matrix is printed as per actual and predicted values of Species
sum(diag(a))/sum(a) #Find Accuracy of the model #Test accuracy is 100% as we have used 100% data in training and testing both.
plot(model) #Plotting the trained model
