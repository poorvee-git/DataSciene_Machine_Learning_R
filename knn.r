wbcd<-read.csv("C:\\Users\\poorvee\\Desktop\\Data_Science\\ExcelR\\R_scripts\\New_batch\\12_May\\wbcd_new.csv")
#2 classes -> B (no cancer), M (Cancer)
#1st column is class variable 

# table of diagnosis
prop.table(table(wbcd$diagnosis))*100  #Proportion of each class 62% and 37%	 ->to check class imbalance problem

# recode diagnosis as a factor
wbcd$diagnosis <- factor(wbcd$diagnosis, levels = c("B", "M"),
                         labels = c("Benign", "Malignant")) # we are factorizing Y variable , chnaging B and M labels to  "Benign", "Malignant"

# create training and test data
wbcd_train <- wbcd[1:469, ]
wbcd_test <- wbcd[470:569, ]

# create labels for training and test data

wbcd_train_labels <- wbcd[1:469, 1] #Collect classes of trained dat set in seperate varibale wbcd_train_labels
wbcd_test_labels <- wbcd[470:569, 1] #Collect classes of trained dat set in seperate varibale wbcd_test_labels
#---- Training a model on the data ----

# load the "class" library
library(class)

wbcd_test_pred <- knn(train = wbcd_train[,-1], 
                      test = wbcd_test[,-1],
                      cl = wbcd_train_labels, k=25) #cl is class #K=25 means find the 25 nearest dat points and find the mode of the classes of those 25 data points #Here we give test data as well while building the model. Because k-nn has to compute distance from all the data points so trained data is also required in the model to get predictions.

##--------Evaluating model performance ----
# load the "gmodels" library
library(gmodels)

# Create the cross tabulation of predicted vs. actual
CrossTable(x = wbcd_test_labels, y = wbcd_test_pred,
           prop.chisq=FALSE,prop.c = FALSE, prop.r = FALSE) #Cross table is like confusion matrix #100 are test data points #model predicted 3 wrong data points as Benign .

## Improving model performance ----

# use the scale() function to z-score standardize a data frame
wbcd_z <- as.data.frame(scale(wbcd[-1])) #High scale data will dominate the distance  we saw this in hierarchal clustering so we need to normalize  or standardize the data #-1 is for removing 1st coloumn
wbcd_z
# confirm that the transformation was applied correctly
summary(wbcd_z$area_mean) #area mean we are collecting just to check that standardization worked correctly or not

# create training and test datasets
wbcd_train <- wbcd_z[1:469, ]
wbcd_test <- wbcd_z[470:569, ]

# re-classify test cases
wbcd_test_pred <- knn(train = wbcd_train, test = wbcd_test,
                      cl = wbcd_train_labels, k=25)
# Create the cross tabulation of predicted vs. actual
CrossTable(x = wbcd_test_labels, y = wbcd_test_pred,
           prop.chisq=FALSE,prop.c = FALSE, prop.r = FALSE)

# try several different values of k
wbcd_train <- wbcd_n[1:469, ]
wbcd_test <- wbcd_n[470:569, ]

wbcd_test_pred <- knn(train = wbcd_train, test = wbcd_test, 
                      cl = wbcd_train_labels, k=1)
CrossTable(x = wbcd_test_labels, y = wbcd_test_pred, prop.chisq=FALSE,prop.c = FALSE, prop.r = FALSE)

wbcd_test_pred <- knn(train = wbcd_train, test = wbcd_test, 
                      cl = wbcd_train_labels, k=5)
CrossTable(x = wbcd_test_labels, y = wbcd_test_pred, prop.chisq=FALSE,prop.c = FALSE, prop.r = FALSE)

wbcd_test_pred <- knn(train = wbcd_train, test = wbcd_test,
                      cl = wbcd_train_labels, k=11)
CrossTable(x = wbcd_test_labels, y = wbcd_test_pred, prop.chisq=FALSE,prop.c = FALSE, prop.r = FALSE)
wbcd_test_pred <- knn(train = wbcd_train, test = wbcd_test, 
                      cl = wbcd_train_labels, k=15)
CrossTable(x = wbcd_test_labels, y = wbcd_test_pred, prop.chisq=FALSE,prop.c = FALSE, prop.r = FALSE)

wbcd_test_pred <- knn(train = wbcd_train, test = wbcd_test, 
                      cl = wbcd_train_labels, k=21)
CrossTable(x = wbcd_test_labels, y = wbcd_test_pred, prop.chisq=FALSE,prop.c = FALSE, prop.r = FALSE)

wbcd_test_pred <- knn(train = wbcd_train, test = wbcd_test, 
                      cl = wbcd_train_labels, k=27)
CrossTable(x = wbcd_test_labels, y = wbcd_test_pred, prop.chisq=FALSE,prop.c = FALSE, prop.r = FALSE)

#Accuracy calculation will be same like confusion matrix ??? sum of diagonal/Total elements
#K=15 we got highest accuracy ??? 97%.this is the best k value for given data set 
#For new data point , we need to combine train and test data set and apply model (ex.k=15) and predict value new data point ??? This process happens for each of the models like random forest, C50 etc to do predictions.
#That is final model will have trained data set as (100% data set) and test data set will have only 1 row and apply the finalized model on it to do predictions