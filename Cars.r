MPG<-read.csv("C:\\Users\\poorvee\\Desktop\\Data_Science\\ExcelR\\R_scripts\\New_batch\\21_Apr\\Cars.csv")

#Scatter Plot Matrix:
pairs(MPG)   #MPG is negative correlation with other X variables

#Correlation Matrix:
cor(MPG)   #Correlation 0 means no correlation between two params, here also MPG is negative correlation with other X variables
#Regression Model and Summary
model.car<-lm(MPG~HP+VOL+SP+WT,data = MPG)
summary(model.car)    #VOL and WT are insignificant variables due to no star
#########Experiment#####################
reg_vol<-lm(MPG~VOL,data = MPG)   #MPG on VOL
summary(reg_vol)   #Alone VOL is significant for MPG
reg_wt<-lm(MPG~WT,data = MPG)  #MPG on WT
summary(reg_wt)  #Alone WT is significant for MPG
#Above found that both params are significant when used alone
reg_wt_vol<-lm(MPG~WT+VOL,data = MPG)
summary(reg_wt_vol) #But when we combine both VOL and WT then they become insignificant. No stars
##################
#Regression Model and Summary
#. dot is for all the data instead of giving HP+VOL+SP+WT. again building same model with all X variables. Below 2 lines are not required and just added to show the usage of dot
model.car<-lm(MPG~.,data = MPG)
summary(model.car)
#Multi-colinearity
#install.packages("car")
library(car)
car::vif(model.car)  #VIF is greater than 20 for VOL and WT, collinearity problem
##Subset selection
library(MASS)
stepAIC(model.car) #AIC value should be low. High AIC means that variable needs to be removed. AIC value is low for MPG ~ HP + VOL + SP . Hence remove WT
#Model Building
#Regression Model and Summary
##Remove WT and build the model again
MPG1=MPG[,-5]
model.car<-lm(MPG~.,data = MPG1)
summary(model.car)
#Diagnostic Plots:
#Residual Plots, QQ-Plos, Std. Residuals vs Fitted
##dotted lines in "Residual vs Leverage" graph shows cook's distance. If any data points crossing 0.5 and 1 are part of outlayers
#Here in all graphs red line should ideally fall on black dotted line.
#In Normal Q-Q graph bubbles should fall on black dotted line
plot(model.car) 
#Residuals vs Regressors
library(car)
residualPlots(model.car) #HP and SP have errors as blue line is not falling on dotted line (No patterns no problems)
#Last Fitted values graph is for Y target variable
#Transformation
#AS HP has more error(more pattern) then transform it by squaring it
MPG1['HP2']<-MPG1$HP*MPG1$HP
model.car<-lm(MPG~.,data = MPG1)
summary(model.car)
residualPlots(model.car) #(No patterns no problems)

#Added Variable Plots
avPlots(model.car) #More the slope then that X variable is more important for Y. HP , SP, VOL are imp
#QQ plots of studentized residuals
##QQ plot with confidence interval , we can find outlayers
qqPlot(model.car) #output is 66 and 71 , so outlayers datapoints are 66 and 71 with 95%confidence
#Deletion Diagnostics
influenceIndexPlot(model.car) # Index Plots of the influence measures #here also found outlayer datapoint is 66
####Iteration 1 
#Iteration 1 is refining the model, keep repeating iteration until we get good accuracy
#Remove 66th observation
MPG2<-MPG1[-66,]
model1<-lm(MPG~.,data = MPG2)
car::vif(model1)
plot(model1) 
residualPlots(model1)
qqPlot(model1)
influenceIndexPlot(model1)
summary(model1)

#iteration2
MPG3<-MPG1[-c(66,79),]
model2<-lm(MPG~.,data = MPG3)
car::vif(model2)
plot(model2) 
residualPlots(model2)
qqPlot(model2)
influenceIndexPlot(model2)
summary(model2)
