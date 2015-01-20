# Week 3. -----------------------------------------------------------------

      #split

x <- c(rnorm(10), runif(10), rnorm(10,1))
f <- gl(3, 10)
split(x, f)
lapply(split(x, f), mean)

library(datasets)
head(airquality)
s <- split(airquality, airquality$Month)
lapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")]))
sapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")]))
sapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")], na.rm=TRUE))

x <- rnorm(10)
f2 <- gl(5, 2)
f1 <- gl(2, 5)
interaction(f1, f2)
str(split(x, list(f1, f2)))
str(split(x, list(f1, f2), drop=TRUE))

      #tapply

x <- c(rnorm(10), runif(10), rnorm(10,1))
f <- gl(3, 10)
tapply(x, f, mean)
tapply(x, f, range)

      #mapply

l1 <- list(rep(1, 4), rep(2, 3), rep(3, 2), rep(4, 1))
l2 <- mapply(rep, 1:4, 4:1)

noise <- function(n, mean, sd) {
      rnorm(n, mean, sd)
}
noise(5, 1, 2)
noise(1:5, 1:5, 2)
mapply(noise, 1:5, 1:5, 2)

      # lapply, apply

x <- list(a = 1:5, b = rnorm(10))
lapply(x, mean)

x <- 1:4
lapply(x, runif)
lapply(x, runif, min = 0, max = 10)

x <- list(a = matrix(1:4, 2, 2), b = matrix(1:6, 3, 2))
lapply(x, function(elt) elt[, 1])

x <- list(1:4, 5:8)
sapply(x, function(ar) ar[1] + ar[4])

x<- matrix (rnorm(200), 20, 10)
apply(x, 1, mean)

rowMeans(x)
colMeans(x)

apply(x, 1, quantile, probs = c(0.25, 0.75))

a <- array(rnorm(2 * 2 * 2), c(2, 2, 10))
apply(a, c(1,2), mean)