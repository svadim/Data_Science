
# Week 3 ------------------------------------------------------------------

## Dimension Reduction ********************************************************

set.seed(12345)
par(mar = rep(0.2, 4))
dataMatrix <- matrix(rnorm(400), nrow = 40)
image(1:10, 1:40, t(dataMatrix)[, nrow(dataMatrix):1])
par(mar = rep(0.2, 4))
heatmap(dataMatrix)

set.seed(678910)
for (i in 1:40) {
      # flip a coin
      coinFlip <- rbinom(1, size = 1, prob = 0.5)
      # if coin is heads add a common pattern to that row
      if (coinFlip) {
            dataMatrix[i, ] <- dataMatrix[i, ] + rep(c(0, 3), each = 5)
      }
}
par(mar = rep(0.2, 4))
image(1:10, 1:40, t(dataMatrix)[, nrow(dataMatrix):1])
par(mar = rep(0.2, 4))
heatmap(dataMatrix)

hh <- hclust(dist(dataMatrix))
dataMatrixOrdered <- dataMatrix[hh$order, ]
par(mfrow = c(1, 3))
image(t(dataMatrixOrdered)[, nrow(dataMatrixOrdered):1])
plot(rowMeans(dataMatrixOrdered), 40:1, , xlab = "Row Mean", ylab = "Row", pch = 19)
plot(colMeans(dataMatrixOrdered), xlab = "Column", ylab = "Column Mean", pch = 19)



## K-means clustering *********************************************************
set.seed(678910)
set.seed(1234)
par(mar = c(0, 0, 0, 0))
x <- rnorm(12, mean = rep(1:3, each = 4), sd = 0.2)
y <- rnorm(12, mean = rep(c(1, 2, 1), each = 4), sd = 0.2)
plot(x, y, col = "blue", pch = 19, cex = 2)
text(x + 0.05, y + 0.05, labels = as.character(1:12))
dataFrame <- data.frame(x, y)
kmeansObj <- kmeans(dataFrame, centers = 3)
names(kmeansObj)
par(mar = rep(0.2, 4))
plot(x, y, col = kmeansObj$cluster, pch = 19, cex = 2)
points(kmeansObj$centers, col = 1:3, pch = 3, cex = 3, lwd = 3)

set.seed(1234)
dataMatrix <- as.matrix(dataFrame)[sample(1:12), ]
kmeansObj2 <- kmeans(dataMatrix, centers = 3)
par(mfrow = c(1, 2), mar = c(2, 4, 0.1, 0.1))
image(t(dataMatrix)[, nrow(dataMatrix):1], yaxt = "n")
image(t(dataMatrix)[, order(kmeansObj$cluster)], yaxt = "n")

## Hierarchical Clustering ****************************************************

set.seed(1234)
par(mar=c(0,0,0,0))
x <- rnorm(12, mean=rep(1:3, each=4), sd=0.2)
y <- rnorm(12, mean=rep(c(1,2,1), each=4), sd=0.2)
plot(x, y, col="blue", pch=19, cex=2)
text(x+0.05, y+0.05, labels=as.character(1:12))
dataFrame <- data.frame(x=x, y=y)
distxy <- dist(dataFrame)
hClustering <- hclust(distxy)
plot(hClustering)

myplclust <- function(hclust, lab = hclust$labels, lab.col = rep(1, length(hclust$labels)), 
                      hang = 0.1, ...) {
      ## modifiction of plclust for plotting hclust objects *in colour*!  Copyright
      ## Eva KF Chan 2009 Arguments: hclust: hclust object lab: a character vector
      ## of labels of the leaves of the tree lab.col: colour for the labels;
      ## NA=default device foreground colour hang: as in hclust & plclust Side
      ## effect: A display of hierarchical cluster with coloured leaf labels.
      y <- rep(hclust$height, 2)
      x <- as.numeric(hclust$merge)
      y <- y[which(x < 0)]
      x <- x[which(x < 0)]
      x <- abs(x)
      y <- y[order(x)]
      x <- x[order(x)]
      plot(hclust, labels = FALSE, hang = hang, ...)
      text(x = x, y = y[hclust$order] - (max(hclust$height) * hang), labels = lab[hclust$order], 
           col = lab.col[hclust$order], srt = 90, adj = c(1, 0.5), xpd = NA, ...)
}
myplclust(hClustering, lab = rep(1:3, each = 4), lab.col = rep(1:3, each = 4))

dataFrame <- data.frame(x = x, y = y)
set.seed(143)
dataMatrix <- as.matrix(dataFrame)[sample(1:12), ]
heatmap(dataMatrix)

# Week 2 ------------------------------------------------------------------

## ggplo2 *********************************************************************

library(ggplot2)
qplot(displ, hwy, data=mpg)
qplot(displ, hwy, data=mpg, color=drv)
qplot(displ, hwy, data=mpg, geom=c("point", "smooth"))
qplot(hwy, data=mpg, fill=drv)
qplot(displ, hwy, data=mpg, facets=.~drv)
qplot(hwy, data=mpg, facets=drv~., binwidth=2)

## Lattice plotting system ****************************************************

library(lattice)
library(datasets)
xyplot(Ozone~Wind, data=airquality)

airquality <- transform(airquality, Month=factor(Month))
xyplot(Ozone ~ Wind | Month, data=airquality, layout=c(5,1))

p <- xyplot(Ozone ~ Wind, data=airquality)
print(p)

set.seed(10)
x <- rnorm(100)
f <- rep(0:1, each=50)
y <- x+f-f*x+rnorm(100, sd=0.5)
f <- factor(f, labels=c("Group 1", "Group 2"))
xyplot(y~x | f, layout=c(2,1))

xyplot(y~x|f, panel=function(x,y, ...){
      panel.xyplot(x, y, ...)
      panel.abline(h=median(y), lty=2)
})

xyplot(y~x|f, panel=function(x,y, ...){
      panel.xyplot(x, y, ...)
      panel.lmline(x, y, col=2)
})


# Week 1 ------------------------------------------------------------------

## Exploratory Graphs *********************************************************

pollution <- read.csv("data/avgpm25.csv", colClasses = c("numeric", "character", 
                                                         "factor", "numeric", "numeric"))
head(pollution)

summary(pollution$pm25)

boxplot(pollution$pm25, col = "red")

hist(pollution$pm25, col="green")
rug(pollution$pm25)

hist(pollution$pm25, breaks=100, col="green")
rug(pollution$pm25)

boxplot(pollution$pm25, col = "red")
abline(h=12)

hist(pollution$pm25, col="green")
abline(v=12, lwd=2)
abline(v=median(pollution$pm25), col="magenta", lwd=4)

barplot(table(pollution$region), col = "wheat", 
        main = "Number of Counties in Each Region")

boxplot(pm25~region, data=pollution, col="blue")

par(mfrow = c(2,1), mar=c(4,4,2,1))
hist(subset(pollution, region=="east")$pm25, col="green")
hist(subset(pollution, region=="west")$pm25, col="green")

with(pollution, plot(latitude, pm25))
abline(h=12, lwd=2, lty=2)

with(pollution, plot(latitude, pm25, col=region))
abline(h=12, lwd=2, lty=2)

par(mfrow = c(1, 2), mar = c(5, 4, 2, 1))
with(subset(pollution, region == "west"), plot(latitude, pm25, main = "West"))
with(subset(pollution, region == "east"), plot(latitude, pm25, main = "East"))

## Plotting Systems in R ******************************************************

library(datasets)
data(cars)
with(cars, plot(speed, dist))

library(lattice)
state <- data.frame(state.x77, region = state.region)
xyplot(Life.Exp ~ Income | region, data = state, layout = c(4, 1))

library(ggplot2)
data(mpg)
qplot(displ, hwy, data = mpg)

## The Base Plotting System in R **********************************************

library(datasets)
hist(airquality$Ozone)

with(airquality, plot(Wind, Ozone))

airquality <- transform(airquality, Month = factor(Month))
boxplot(Ozone ~ Month, airquality, xlab = "Month", ylab = "Ozone (ppb)")

par("lty")
par("col")
par("pch")

with(airquality, plot(Wind, Ozone))
title(main = "Ozone and Wind in New York City")  ## Add a title

with(airquality, plot(Wind, Ozone, main = "Ozone and Wind in New York City"))
with(subset(airquality, Month == 5), points(Wind, Ozone, col = "blue"))

with(airquality, plot(Wind, Ozone, 
                      main = "Ozone and Wind in New York City", type = "n"))
with(subset(airquality, Month == 5), points(Wind, Ozone, col = "blue"))
with(subset(airquality, Month != 5), points(Wind, Ozone, col = "red"))
legend("topright", pch = 1, col = c("blue", "red"), legend = c("May", "Other Months"))

with(airquality, plot(Wind, Ozone, 
                      main = "Ozone and Wind in New York City", pch = 20))
model <- lm(Ozone ~ Wind, airquality)
abline(model, lwd = 2)

par(mfrow = c(1, 2))
with(airquality, {
      plot(Wind, Ozone, main = "Ozone and Wind")
      plot(Solar.R, Ozone, main = "Ozone and Solar Radiation")
})

par(mfrow = c(1, 3), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
with(airquality, {
      plot(Wind, Ozone, main = "Ozone and Wind")
      plot(Solar.R, Ozone, main = "Ozone and Solar Radiation")
      plot(Temp, Ozone, main = "Ozone and Temperature")
      mtext("Ozone and Weather in New York City", outer = TRUE)
})

example(plot)

## Graphics Devices in R ######################################################

?Devices

library(datasets)
with(faithful, plot(eruptions, waiting))  ## Make plot appear on screen device
title(main = "Old Faithful Geyser data")  ## Annotate with a title

pdf(file = "myplot.pdf")  ## Open PDF device; create 'myplot.pdf' in my working directory
## Create plot and send to a file (no plot appears on screen)
with(faithful, plot(eruptions, waiting))
title(main = "Old Faithful Geyser data")  ## Annotate plot; still nothing on screen
dev.off()  ## Close the PDF file device

with(faithful, plot(eruptions, waiting))  ## Create plot on screen device
title(main = "Old Faithful Geyser data")  ## Add a main title
dev.copy(png, file = "geyserplot.png")  ## Copy my plot to a PNG file
dev.off()  ## Don't forget to close the PNG device!