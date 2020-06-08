install.packages("jpeg","imager","pixmap")
library(jpeg)
library(imager)
library(pixmap)

cat <- readJPEG('C:\\Users\\poorvee\\Desktop\\Data_Science\\ExcelR\\R_scripts\\New_batch\\28_Apr\\cat.jpg')

ncol(cat) # we have 600 columns
nrow(cat) # we have 398 columns
#Total values we have from 1 Red grid 600*398 = 238800 . As we 3 grids so 600*398*3 = 716400
r <- cat[,,1] #getting values of red grid i.e. actual red data values from image
g <- cat[,,2] #getting values of green grid i.e. actual gree data values from image
b <- cat[,,3] #getting values of blue grid i.e. actual blue data values from image

#PCA we will apply on separate grid: R , G, B  
cat.r.pca <- prcomp(r, center = FALSE) #here we are getting scores from red grid #center = FALSE is doen as we don't want do scaling we don't want convert data to same scale 
cat.g.pca <- prcomp(g, center = FALSE) #here we are getting scores from green grid 
cat.b.pca <- prcomp(b, center = FALSE) #here we are getting scores from blue grid 

rgb.pca <- list(cat.r.pca, cat.g.pca, cat.b.pca) #cobining all 3 grids
pca.img <- sapply(rgb.pca, function(j) {  compressed.img <- j$x[,1:100] %*% t(j$rotation[,1:100])}, simplify = 'array') #Generating image with 100 columns #if you will replace 100 with 10 then we will get blur image
a<-pixmap::pixmapRGB(pca.img)
windows()
plot(a)  #for printing image with 100 columns
#From 100 columns we are getting good image instead of 600 columns
