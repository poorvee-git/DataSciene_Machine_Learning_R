#In the code We are seeing recommnedation of movies 
#a) finding which Top 5 movies are recommended for all the customers by recommendation engine
#b) 1st customr saw only 1 movie then which other movie he might be intersted as per recommendation engine.

#Installing and loading the libraries
install.packages("recommenderlab", dependencies=TRUE)
install.packages("Matrix")
install.packages("caTools")

library(recommenderlab)
library(caTools)
library(caTools)
#movie rating data
movie_rate_data <-read.csv("C:\\Users\\poorvee\\Desktop\\Data_Science\\ExcelR\\R_scripts\\New_batch\\29_Apr\\Movie.csv")
#metadata about the variable
str(movie_rate_data)
#rating distribution by creating histogram 
hist(movie_rate_data$rating) #Most of the people gave rating 3 and 4

#the datatype should be realRatingMatrix inorder to build recommendation engine
movie_rate_data_matrix <- as(movie_rate_data, 'realRatingMatrix') #Tranform data set matrix to realrating Matrix i.e. with column has movie name , each row is unique per customer and fill the rating accordingly
movie_rate_data_matrix@data #see tranformed data matrix #Ex. 4th guy saw 2 movies and given ratings as 4.0 and 3.0
#Popularity based
movie_recomm_model1 <- Recommender(movie_rate_data_matrix, method="POPULAR") #recommendation engine based on POPULAR method #gives list of similar customers

#Predictions for two users 
recommended_items1 <- predict(movie_recomm_model1, movie_rate_data_matrix, n=5) #n=5 means top 5 movie recommendations #predict recommended top 5 movies for all customers

as(recommended_items1, "list")  #View recommended 5 movies for all customers
recommended_items1 <- predict(movie_recomm_model1, movie_rate_data_matrix[1], n=5) #predict recommended top 5 movies for 1st customer i.e. predict recommendation of 1st customer for top 5 movies
as(recommended_items1, "list") #View recommended 5 movies for 1st customer

## Popularity model recommends the same movies for all users , we need to improve our model using # # Collaborative Filtering

#User Based Collaborative Filtering #In this example POPULAR method will be discarded UBCF method is much better

movie_recomm_model2 <- Recommender(movie_rate_data_matrix, method="UBCF") #UBCF is user based collabartive filtering method of recommendation engine

#Predictions for all users 
recommended_items2 <- predict(movie_recomm_model2, movie_rate_data_matrix, n=5) #n=5 means top 5 movie recommendations #predict recommended top 5 movies for all customers
as(recommended_items2, "list") #View recommended 5 movies for all customers
recommended_items2 <- predict(movie_recomm_model2, movie_rate_data_matrix[1], n=5) #predict recommended top 5 movies for 1st customer i.e. predict recommendation of 1st customer for top 5 movies
as(recommended_items2, "list") #View recommended 5 movies for 1st customer

#Collaborative Filtering is Which movies are watched by most of the customers and out of which which top 5 movies has highest rating, create gropuing


