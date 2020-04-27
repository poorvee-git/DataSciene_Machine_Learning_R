#Load data
WC_AT<-read.csv("C:\\Users\\poorvee\\Desktop\\Data_Science\\ExcelR\\R_scripts\\New_batch\\17_Apr\\WC_AT.csv")

# Visualization
install.packages("lattice")
library(lattice)
#lattice package was used for generating dot plot . these below 4 lines can be removed as well
dotplot(WC_AT$AT, main="Dot Plot of AT values",col="dodgerblue4")
dotplot(WC_AT$Waist, main="Dot Plot of Waist values", col="dodgerblue4")
boxplot(WC_AT$AT,col="dodgerblue4")
boxplot(WC_AT$Waist,col="dodgerblue4")
#Regression equation
#Syntax  model<-lm(y~x,data=data set name)
# lm means linear model
colnames(WC_AT)
model<- lm(AT~Waist,data =WC_AT)
#From summary function we can get B0 and B1 values See coefficient o/p (Estimate Std. coloumn)
summary(model)

newdata=data.frame(Waist=40)
at_1=predict(model,newdata=newdata)
at_1

newdata=data.frame(Waist=75)
at_2=predict(model,newdata=newdata)
at_2

newdata=data.frame(Waist=100)
at_3=predict(model,newdata=newdata)
at_3

#predicted AT values are
#40 Waist --> -77.62     75 Waist--> 43.43   100 Waist--> 129.90

# or to add new data frames all together and finding AT values for each 
newdata=data.frame(Waist=c(40,75,100))
at_values=predict(model,newdata=newdata)
at_values
