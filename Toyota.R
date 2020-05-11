Data<-read.csv("C:\\Users\\poorvee\\Desktop\\Data_Science\\ExcelR\\R_scripts\\New_batch\\21_Apr\\Toyoto_Corrola.csv")

colnames(Data)
#Scatter Plot Matrix:
pairs(Data[,3:10])   #Price correlation with other X variables #Removed first 2 columns #columns can be removed by new_Data<-Data[,-c(1,2)]

#Correlation Matrix:
cor(Data[,3:10])   #Correlation 0 means no correlation between two params, here also Price is negative correlation with Age and KM. HP,DOORS,Gears are low degree of positive correlation, Weight is positively correlated, Cylinders are N/A
#Regression Model and Summary
#building model by taking all X variables
toyota<-lm(Price~Age_08_04+KM+HP+Doors+Cylinders+Gears+Weight,data = Data)
summary(toyota)    #Doors and Cylinders are insignificant variables due to no star
Data$Cylinders #Hers we see all values as 4, that means  no variance is there.  this why it is NA in summary. So this coloumn also can be removed from Dataset
Data1<-Data[,-c(1,2,8)]
#Regression Model and Summary
toyota<-lm(Price~.,data = Data1)
summary(toyota)
#########Experiment#####################
reg_doors<-lm(Price~Doors,data = Data)   #Price on Doors
summary(reg_doors)   #Alone Doors is significant for Price
#Below 4 lines of code not required as cylinder we have already removed above
##reg_cyl<-lm(Price~Cylinders,data = Data)  #Price on Cylinders
##summary(reg_cyl)  #Alone Cylinders is insignificant for Price
#Above found that only Doors is significant when used alone
##reg_doors_cyl<-lm(Price~Doors+Cylinders,data = Data)
##summary(reg_doors_cyl) #But when we combine both Doors and cylinders then also cylinders is insignificant. No stars
##################

#Multi-colinearity
install.packages("car")
library(car)
car::vif(toyota)  #VIF is not greater than 20 for any variable that means there is no collinearity problem
#There is no colinearity problem so below no need to look AIC and no need to remove doors based on AIC
##Subset selection
#library(MASS)
#stepAIC(toyota) #AIC value should be low. High AIC means that variable needs to be removed. AIC is low for Price ~ Age_08_04 + KM + HP + Gears + Weight  i.e. without Doors
#Model Building
#Regression Model and Summary 
#Again building model by removing Doors as it has no slope
#toyota<-lm(Price~Age_08_04+KM+HP+Gears+Weight,data = Data)
#summary(toyota)

#Diagnostic Plots:
#Residual Plots, QQ-Plos, Std. Residuals vs Fitted
##dotted lines in "Residual vs Leverage" graph shows cook's distance. If any data points crossing 0.5 and 1 are part of outlayers
#Here in all graphs red line should ideally fall on black dotted line.
#In Normal Q-Q graph bubbles should fall on black dotted line
plot(toyota)
#Residuals vs Regressors
library(car)
residualPlots(toyota) #Age_08_04 have errors as blue line is not falling on dotted line
#Last Fitted values graph is for Y target variable
#Added Variable Plots
avPlots(toyota) #More the slope then that X variable is more important for Y. Age_08_04 , KM and Weight are imp
#QQ plots of studentized residuals
##QQ plot with confidence interval , we can find outlayers
qqPlot(toyota) #output is 222 and 602, so outlayer datapoints are 222 and 602
#Deletion Diagnostics
influenceIndexPlot(toyota) # Index Plots of the influence measures #here also found outlayer datapoints are 222 and 602
####Iteration 1 
#Iteration 1 is refining the model, keep repeating iteration until we get good accuracy
#Remove 222 observation and build the model again
Data2<-Data1[-222,]
model1<-lm(Price~.,data = Data2)
car::vif(model1)
plot(model1)
residualPlots(model1)
qqPlot(model1)  #961 is outlayer datpoint
influenceIndexPlot(model1)
summary(model1)

#iteration2
Data3<-Data1[-c(222,961),]
#Remove 222 and 961 observation and build the model again
model2<-lm(Price~.,data = Data3)
car::vif(model2)
plot(model2) 
residualPlots(model2)
qqPlot(model2)  #602 is outlayer datpoint
influenceIndexPlot(model2)
summary(model2)

#iteration3
Data4<-Data1[-c(222,961,602),]
#Remove 222, 961 and 602 observation and build the model again
model3<-lm(Price~.,data = Data4)
car::vif(model3)
plot(model3) 
residualPlots(model3) #Age_08_04 have errors as blue line is not falling on dotted line
qqPlot(model3)  #602 is outlayer datpoint
influenceIndexPlot(model3)
summary(model3)

#Transformation
#AS Age_08_04 has more error(more pattern) then transform it by squaring it
Data4['Age2']<-Data4$Age_08_04*Data4$Age_08_04
model4<-lm(Price~.,data = Data4)
summary(model4)
car::vif(model4)
plot(model4) 
residualPlots(model4) 
qqPlot(model4)  
influenceIndexPlot(model4)

