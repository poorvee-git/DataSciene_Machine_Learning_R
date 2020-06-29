data("iris")
install.packages("rpart")
library("rpart")
install.packages("caretEnsemble")
library(caretEnsemble)
install.packages("caret")
library(caret)
install.packages("e1071")
library(e1071)

#we'll prepare a binary class dataset from iris data and split it into train and test parts.
ir = iris[iris$Species!="setosa", ]
ir #so Y rows include only versicolor and virginica so model and predictions done for these 2 clasess only
ir$Species = factor(ir$Species)


#Data partition for model building and testing
set.seed(7) #Seed to produce consistent results on multiple runs
inTraininglocal<-createDataPartition(ir$Species,p=.70,list = F) #70% training data points
training<-ir[inTraininglocal,]
testing<-ir[-inTraininglocal,]

#Generating 2 models via C5.0 and CART methods
#rpart is CART method 
models <- caretEnsemble::caretList(
  x=training[,-5],
  y=training[,-c(1,2,3,4)],
  trControl=trainControl(method="cv", classProbs=TRUE),
  methodList=c("C5.0", "rpart")
)
#combining above models via stacking which uses C5.0 method
model<-caretEnsemble::caretStack(models, method="C5.0") #caretStack is used to Combine several predictive models via stacking
#Generate the model summary
summary(model)

#Predict from test data set
pred<-predict(model,newdata=testing[,-5]) # do predection of 30% dataset as per trained model
a<-table(testing$Species,pred) #getting actual and predicted values of Species
a #confusion matrix is printed as per actual and predicted values of Species
sum(diag(a))/sum(a) #Find Accuracy of the model #Test accuracy is 0.933 (93%)
plot(model) #Plotting the trained model
