
                        ## Week 3 ##

# Caching the Mean of a Vector --------------------------------------------

makeVector <- function(x = numeric()) {
      m <- NULL
      set <- function(y) {
            x <<- y
            m <<- NULL
      }
      get <- function() x
      setmean <- function(mean) m <<- mean
      getmean <- function() m
      list(set = set, get = get,
           setmean = setmean,
           getmean = getmean)
}

cachemean <- function(x, ...) {
      m <- x$getmean()
      if(!is.null(m)) {
            message("getting cached data")
            return(m)
      }
      data <- x$get()
      m <- mean(data, )
      x$setmean(m)
      m
}

# Debugging Tools ---------------------------------------------------------

printmessage <- function(x) {
      if(x > 0)
            print("x is greather than zero")
      else
            print("x is less than or equal to zero")
      invisible(x)
}

printmessage2 <- function(x) {
      if(is.na(x))
            print("x is missing value")
       else if(x > 0)
            print("x is greather than zero")
       else 
            print("x is less than or equal to zero")
      invisible(x)
}

lm(y ~ x)
traceback()

debug(lm)
lm(y ~ x)

# split -------------------------------------------------------------------

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

# tapply ------------------------------------------------------------------

x <- c(rnorm(10), runif(10), rnorm(10,1))
f <- gl(3, 10)
tapply(x, f, mean)
tapply(x, f, range)

# mapply ------------------------------------------------------------------

l1 <- list(rep(1, 4), rep(2, 3), rep(3, 2), rep(4, 1))
l2 <- mapply(rep, 1:4, 4:1)

noise <- function(n, mean, sd) {
      rnorm(n, mean, sd)
}
noise(5, 1, 2)
noise(1:5, 1:5, 2)
mapply(noise, 1:5, 1:5, 2)

# lapply, apply -----------------------------------------------------------

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

                        ## Week 2 ##

# Programming assignment 1 ------------------------------------------------

dataset_url <- "http://s3.amazonaws.com/practice_assignment/diet_data.zip"
download.file(dataset_url, "diet_data.zip")
unzip("diet_data.zip", exdir = "diet_data")

list.files("diet_data")

andy <- read.csv("diet_data/Andy.csv")
head(andy)

length(andy$Day)
dim(andy)

str(andy)
summary(andy)
names(andy)

andy[1, "Weight"]
andy[30, "Weight"]
andy[which(andy$Day == 30), "Weight"]
andy[which(andy[, "Day"] == 30), "Weight"]
subset(andy$Weight, andy$Day == 30)

andy_start <- andy[1, "Weight"]
andy_end <- andy[30, "Weight"]

andy_loss <- andy_start - andy_end
andy_loss

files <- list.files("diet_data")
files

files[1]
files[2]
files[3:5]

head(read.csv(files[3]))

files_full <- list.files("diet_data", full.names = TRUE)
files_full

head(read.csv(files_full[3]))

andy_david <- rbind(andy, read.csv(files_full[2]))

head(andy_david)
tail(andy_david)

day_25 <- andy_david[andy_david$Day == 25, ]
day_25

for(i in 1:5) {
      print(i)
}

dat <- data.frame()
for(i in 1:5) {
      dat <- rbind(dat, read.csv(files_full[i]))
}
str(dat)

for(i in 1:5) {
      dat2 <- data.frame()
      dat2 <- rbind(dat2, read.csv(files_full[i]))
}
str(dat2)
head(dat2)

median(dat$Weight)

median(dat$Weight, na.rm = TRUE)

dat_30 <- dat[which(dat$Day == 30), ]
dat_30
median(dat_30$Weight)

weigthmedian <- function(directory, day){
      files_list <- list.files(directory, full.names = TRUE)
      dat <- data.frame()
      for(i in 1:5) {
            dat <- rbind(dat, read.csv(files_list[i]))
      }
      dat_subset <- dat[which(dat$Day == day), ]
      median(dat_subset$Weight, na.rm = TRUE)
}

weigthmedian(directory = "diet_data", day = 20)
weigthmedian("diet_data", 4)
weigthmedian("diet_data", 17)

summary(files_full)
tmp <- vector(mode = "list", length = length(files_full))
summary(tmp)

for(i in seq_along(files_full)) {
      tmp[[i]] <- read.csv(files_full[[i]])
}
str(tmp)

str(lapply(files_full, read.csv))

str(tmp[[1]])
head(tmp[[1]][,"Day"])

output <- do.call(rbind, tmp)
str(output)
