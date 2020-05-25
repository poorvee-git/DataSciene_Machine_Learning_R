claimants<-read.csv("C:\\Users\\poorvee\\Desktop\\Data_Science\\ExcelR\\R_scripts\\New_batch\\23_Apr\\claimants.csv")

# Linear Regression
colnames(claimants)
#Build Model without CASENUM coloumn
#factor is taken for categorial variables
fit=lm(ATTORNEY ~ factor(CLMSEX) + factor(CLMINSUR) + factor(SEATBELT)	
       + CLMAGE + LOSS,data=claimants)
summary(fit) #Multiple R-squared:  0.06741 . this is very bad accuracy but doesn't matter in Logistic Regression

plot(fit)
# Logistic Regression
# To create Logistic Regression glm function is used with additional argument family= "binomial". glm is generalized linear model.
logit=glm(ATTORNEY ~ factor(CLMSEX) + factor(CLMINSUR) + factor(SEATBELT) 
          + CLMAGE + LOSS,family= "binomial",data=claimants)
summary(logit)

# Odds Ratio
#Find coefficient of all variable
exp(coef(logit))

# Confusion Matrix Table
#Predict values for each row using logistic model
prob=predict(logit,type=c("response"),claimants)
prob
#Now compute the accuracy of this model. 
#Confusion MAtrix method (used mostly than ROC) to find accuracy of logistic regression
#First confusion matrix needs to be built
confusion<-table(prob>0.5,claimants$ATTORNEY) #if probability value prob is more than 0.5 then consider probability value as 1 and compare it with actual attorney value and in this way generate confusion matrix
confusion
# Model Accuracy
#Accuracy for logistic regression needs to be find by diagonal addition (380+393) = 773 and divide by total observations
Accuracy<-sum(diag(confusion))/sum(confusion) 
Accuracy #70%  this is good model If value is closer to 1 that is good model

#ROC is another method to find accuracy of logistic regression 
install.packages("ROCR")
library(ROCR)
rocrpred<-prediction(prob,claimants$ATTORNEY) #find prediction using roc
rocrperf<-performance(rocrpred,'tpr','fpr') #find performance using roc prediction. tpr is true prediction , fpr is false prediction
#Generate curve using roc performance value
plot(rocrperf,colorize=T,text.adj=c(-0.2,1.7)) #Curve is above of diagonal line and if curve is above diagonal line that means it is good algorithm of logistic regression

install.packages("pROC")
library(pROC) #pROC Package is required for auc function
auc <- auc(claimants$ATTORNEY ~ prob) #auc is area under the curve
auc #76%  this is good model If value is closer to 1 that is good model

