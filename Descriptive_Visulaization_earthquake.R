e_quakes<-datasets::quakes
View(e_quakes)

head(e_quakes)
tail(e_quakes)
e_quakes$depth
e_quakes[,3:5]
e_quakes[,c(1,3)]

####################
summary(e_quakes$depth)
summary(e_quakes)
####################

#PLOTS
par(mfrow=c(1,1)) #to keep 1 graph in Plots window
#scatter plot
plot(e_quakes)
plot (e_quakes$mag)
plot (e_quakes$mag, col='red', type='b')
plot (e_quakes$depth,e_quakes$mag, xlab='depth of eartquake', ylab='mag of eartquake', main='earthquake scatter plot', col='green')

# points and lines 
plot (e_quakes$depth, type='l') # p: points, l: lines,b: both

#Horizontal barplot
barplot(e_quakes$mag, main = 'Eartquake Mag',
        xlab = 'mag level', col= 'blue',horiz = F)
barplot(e_quakes$mag,e_quakes$depth)

#histogram
hist(e_quakes$depth, col='blue')
hist(e_quakes$depth,
     main = 'depth values in earthquake',
     xlab = 'depth', col='blue')

#Single box plot
boxplot(e_quakes$mag)

# Multiple box plots
boxplot(e_quakes[,2:4], main='multiple')
boxplot(e_quakes)

#margin of the grid(mar), 
#no of rows and columns(mfrow), 
#whether a border is to be included(bty) 
#and position of the 
#labels(las: 1 for horizontal, las: 0 for vertical)
#bty - box around the plot

par(mfrow=c(3,3),mar=c(2,5,2,1),  las=1, bty="o")
plot(e_quakes$depth)
plot(e_quakes$depth, e_quakes$mag)
plot(e_quakes$depth, type= "l")
plot(e_quakes$depth, type= "l")
plot(e_quakes$depth, type= "l")
barplot(e_quakes$depth, main = 'earthquake depth',
        xlab = 'depth levels', col='green',horiz = TRUE)
hist(e_quakes$depth)
boxplot(e_quakes$mag)
boxplot(e_quakes[,0:4], main='Multiple Box plots')


