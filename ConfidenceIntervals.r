install.packages("gmodels")
library(gmodels)
install.packages('nycflights13')
library(nycflights13)
data<-nycflights13::flights

dep_delay<-data$dep_delay
#ar_delay<-data$arr_delay
dep_delay1<-dep_delay[!is.na(dep_delay)]
#In ci function, confidence = 0.95 by defult
ci(dep_delay1)
#from ci function we get Estimate which is x bar (mean of sample) 
ci(dep_delay1,confidence = 0.95)
#12.50157021 12.77657031 departure delay will be expected for any flight departure