# Week 3. -----------------------------------------------------------------

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