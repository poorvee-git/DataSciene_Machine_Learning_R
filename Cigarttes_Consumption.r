#Import Data:
cigarette_consumption<-read.csv("C:\\Users\\poorvee\\Desktop\\Data_Science\\ExcelR\\R_scripts\\New_batch\\20_Apr\\Cigarttes.csv")

#Scatter Plot Matrix:
pairs(cigarette_consumption[,2:8])
#Correlation  
#Correlation Matrix:
cor(cigarette_consumption[,2:8])

#EDA end here
#Regression Model:
reg.model<-lm(Sales~Age+HS+Income+Black+Female+Price,data = cigarette_consumption)
summary(reg.model)
