#Load data
Nd<-read.csv("C:\\Users\\poorvee\\Desktop\\Data_Science\\ExcelR\\R_scripts\\New_batch\\16_Apr\\NewspaperData.csv")

# Visualization
install.packages("lattice")
library(lattice)
#lattice package was used for generating dot plot
dotplot(Nd$sunday, main="Dot Plot of Sunday Circulations",col="dodgerblue4")
dotplot(Nd$daily, main="Dot Plot of Daily Circulations", col="dodgerblue4")
boxplot(Nd$sunday,col="dodgerblue4")
boxplot(Nd$daily,col="dodgerblue4")
#Regression equation
#Syntax  model<-lm(y~x,data=data set name)
# lm means linear model
colnames(Nd)
model<- lm(sunday~daily,data =Nd)
#From summary function we can get B0 and B1 values See coefficient o/p (Estimate Std. coloumn)
summary(model)
sun= 13.84 + (1.34*200)
sun

#Instead of finding above sun value manually like sun= 13.84 + (1.34*200) we can use below 3 lines of code as well
newdata=data.frame(daily=200)
sun1=predict(model,newdata=newdata)
sun1
#sun1 and sun values are almost same so we can reject sun calculation line
#We found that if daily value is 200 then predicted Sunday value is 281.7786

#Below we are predicting y hat value for each X value
pred<-predict(model)
pred
#Below we are predicting y hat value for each X value, and calculating error as well via actual Y - Y hat
pred<-predict(model)
finaldata<-data.frame(Nd,pred,"Error"= Nd$sunday-pred)
finaldata

