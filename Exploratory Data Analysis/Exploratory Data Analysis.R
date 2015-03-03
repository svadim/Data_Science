
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