#We want to test with k=9,13,19 in 1 shot and find the accuracy for each k and select the best 1 . To automate the previous activity we will use below code

# load the library
library(caret)
# load the dataset
data(iris)


ctrl <- trainControl(method="repeatedcv",repeats = 3)  #CV is cross validation , Data will be divided into 10 parts or 10 folds. (this 10 is constant) and each fold get chance in model testing #Repeatedcv =3 means repeat above 10 iteration 3 times
each fold get chance in model testing

my_knn_model <- train(Species ~ .,
                      method = "knn",
                      data = iris,
                      trControl=ctrl,
                      tuneGrid = expand.grid(k = c(9, 13, 19))) #For each K value repeat above ctrl process
my_knn_model
