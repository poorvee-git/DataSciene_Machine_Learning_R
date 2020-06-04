install.packages("arules")
library(arules)  #to use apriori function
Titanic<-read.csv("C:\\Users\\poorvee\\Desktop\\Data_Science\\ExcelR\\R_scripts\\New_batch\\27_Apr\\Titanic.csv")
#read.transactions("data,csv", sep = ",") #this is used to read transational data set
Titanic<-Titanic[,-c(1)] #Removing 1st column
rules <- apriori(Titanic) #apriori function is used to generate rules # similar like lm function in linear regression
arules::inspect(rules) #Look into all the rules
rules.sorted <- sort(rules, by="lift") #Sort the data based on lift ratio
arules::inspect(rules.sorted) #Look into sorted lift ratio rules 
#Above 2 sort lines are not mandatory

# rules with rhs containing "Survived" only
rules <- apriori(Titanic,parameter = list(supp=0.1, conf=0.5)
                 ,appearance = list(rhs=c("Survived=No", "Survived=Yes")
                 ),control = list(verbose=F)) 
#I want all the rules which has of support equal or greater than 0.1  and confidence with equal or greater than 0.5 
#this is to reduce the no. of rules
#Now We want to display survived yes/no and then associate it's corresponding value count and check lift
#verbose=F for removing text information we get in alogorithm as this is not required
arules::inspect(rules)
rules.sorted <- sort(rules, by="lift") #Sort the data based on lift ratio again 
arules::inspect(rules.sorted) #Look into sorted lift ratio rules again
