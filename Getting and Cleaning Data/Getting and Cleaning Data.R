
# Week 3 ------------------------------------------------------------------

## Quiz 3

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(url, "data.csv")
data <- read.csv("data.csv")
agricultureLogical <- data$ACR==3&data$AGS==6
which(agricultureLogical)

library(jpeg)
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(url, "picture.jpg", mode="wb")
jpeg <- readJPEG("picture.jpg", native = TRUE)
quantile(jpeg, probs = c(0.3, 0.8))

library(dplyr)
url1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
url2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(url1, "file1.csv", mode="wb")
download.file(url2, "file2.csv", mode="wb")
file1 <- read.csv("file1.csv", stringsAsFactors=F)
file2 <- read.csv("file2.csv", stringsAsFactors=F)
rank <- match(file1[,2], as.character(c(1:190)))
file1 <- file1[!is.na(rank),]
file1[,2] <- as.numeric(file1[,2])
data <- merge(file1, file2, by.x="X", by.y="CountryCode")
data_arr <- arrange(data, desc(data[,2]))
nrow(data)
data_arr[13,4]

data_arr %>% group_by(Income.Group) %>%
      summarize(mean(Gross.domestic.product.2012))

library(Hmisc)
r <- cut2(data_arr[,2], g=5)
table(r, data_arr$Income.Group)


## Merging data ***************************************************************

if(!file.exists("data")){dir.create("data")}
fileUrl1 <- "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
fileUrl2 <- "https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"
download.file(fileUrl1, "data/reviews.csv", mode="wb")
download.file(fileUrl2, "data/solutions.csv", mode="wb")
reviews <- read.csv("data/reviews.csv")
solutions <- read.csv("data/solutions.csv")
head(reviews,2)
head(solutions,2)
names(reviews)
names(solutions)

mergedData = merge(reviews,solutions,by.x="solution_id",by.y="id",all=TRUE)
head(mergedData)

intersect(names(solutions),names(reviews))
mergedData2 = merge(reviews,solutions,all=TRUE)
head(mergedData2)

library(plyr)
df1 = data.frame(id=sample(1:10),x=rnorm(10))
df2 = data.frame(id=sample(1:10),y=rnorm(10))
arrange(join(df1,df2),id)

df3 = data.frame(id=sample(1:10),z=rnorm(10))
dfList = list(df1,df2,df3)
join_all(dfList)

## dplyr **********************************************************************
library(dplyr)
chicago <- readRDS("chicago.rds")
dim(chicago)
str(chicago)
names(chicago)
head(select(chicago, city:dptp))
head(select(chicago, -(city:dptp)))
i <- match("city", names(chicago))
j <- match("dptp", names(chicago))
head(chicago[, -(i:j)])

chic.f <- filter(chicago, pm25tmean2 > 30)
chic.f <- filter(chicago, pm25tmean2 > 30 & tmpd > 80)

chicago <- arrange(chicago, date)
chicago <- arrange(chicago, desc(date))

chicago <- rename(chicago, pm25=pm25tmean2, dewpoint=dptp)

chicago <- mutate(chicago, pm25detrend=pm25-mean(pm25, na.rm=TRUE))
head(select(chicago, pm25, pm25detrend))
chicago <- mutate(chicago, tempcat = factor(1*(tmpd>80), labels=c("cold", "hot")))
hotcold <- group_by(chicago, tempcat)
summarize(hotcold, pm25=mean(pm25, na.rm=TRUE), o3=max(o3tmean2), no2=median(no2tmean2))
chicago <- mutate(chicago, year=as.POSIXlt(date)$year+1900)
years <- group_by(chicago, year)
summarize(years, pm25=mean(pm25, na.rm=TRUE), o3=max(o3tmean2), no2=median(no2tmean2))

chicago %>% mutate(month=as.POSIXlt(date)$mon +1)%>%
      group_by(month)%>%
      summarize(pm25=mean(pm25,na.rm=TRUE), 
                o3 = max(o3tmean2, na.rm = TRUE), 
                no2=median(no2tmean2, na.rm =TRUE))


## Reshaping data**************************************************************
library(reshape)
library(reshape2)
mtcars$carname <- rownames(mtcars)
carMelt <- melt(mtcars, id=c("carname", "gear", "cyl"), measure.var=c("mpg", "hp"))
cylDate <- dcast(carMelt, cyl ~ variable)
cylDate <- dcast(carMelt, cyl ~ variable, mean)

library(plyr)
tapply(InsectSprays$count, InsectSprays$spray, sum)
spIns <- split(InsectSprays$count, InsectSprays$spray)
sprCount <- lapply(spIns, sum)
unlist(sprCount)
sapply(spIns, sum)
ddply(InsectSprays, .(spray), summarize, sum=sum(count))
spraySums <- ddply(InsectSprays, .(spray), summarize, sum=ave(count, FUN=sum))


## Creating new variables******************************************************
if(!file.exists("data")) dir.create("data")
url <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(url, "data/restaurants.csv", mode = "wb")
restData <- read.csv("data/restaurants.csv")

s1 <-seq(1, 10, by=2)
s2 <- seq(1, 10, length=3)
x <- c(1, 3, 10, 25, 40)
seq(along=x)

restData$nearMe <- restData$neighborhood %in% c("Roland Park", "Homeland")
table(restData$nearMe)

restData$zipWrong <- ifelse(restData$zipCode < 0, TRUE, FALSE)
table(restData$zipWrong, restData$zipCode < 0)

restData$zipGroups <- cut(restData$zipCode, breaks=quantile(restData$zipCode))
table(restData$zipGroups)
table(restData$zipGroups, restData$zipCode)
library(Hmisc)
restData$zipGroups <- cut2(restData$zipCode, g=4)
table(restData$zipGroups)

restData$zsf <- factor(restData$zipCode)
restData$zsf[1:10]

yesno <- sample(c("yes", "no"), size=10, replace=TRUE)
yesnofac <- factor(yesno, levels=c("yes", "no"))
relevel(yesnofac, ref="yes")
as.numeric(yesnofac)

library(plyr)
restData2 <- mutate(restData, zipGroups=cut2(zipCode, g=4))
table(restData2$zipGroups)


##Summarizing data ************************************************************
if(!file.exists("data")) dir.create("data")
url <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(url, "data/restaurants.csv", mode = "wb")
restData <- read.csv("data/restaurants.csv")

head(restData, n=3)
tail(restData, n=3)
summary(restData)
str(restData)
quantile(restData$councilDistrict, na.rm = T)
quantile(restData$councilDistrict, probs=c(0.5, 0.75, 0.9))
table(restData$zipCode, useNA = "ifany")
table(restData$councilDistrict, restData$zipCode)
sum(is.na(restData$councilDistrict))
any(is.na(restData$councilDistrict))
all(restData$zipCode > 0)
colSums(is.na(restData))
all(colSums(is.na(restData)) == 0)
table(restData$zipCode %in% c("21212", "21213"))
restData[restData$zipCode %in% c("21212", "21213"),]

data(UCBAdmissions)
DF <- as.data.frame(UCBAdmissions)
summary(DF)
xt <- xtabs(Freq ~ Gender + Admit, data=DF)
ftable(xt)

warpbreaks$replicate <- rep(1:9, len = 54)
xt <- xtabs(breaks ~.,data=warpbreaks)

fakeData = rnorm(1e5)
object.size(fakeData)
print(object.size(fakeData),units="Mb")

##Subsetting and sorting ******************************************************
set.seed(13435)
X <- data.frame("var1"=sample(1:5), "var2"=sample(6:10), "var3"=sample(11:15))
X <- X[sample(1:5),]; X$var2[c(1,3)]=NA

X[,1]
X[,"var1"]
X[1:2,"var2"]

X[(X$var1 <= 3 & X$var3 > 11), ]
X[(X$var1 <= 3 | X$var3 > 11), ]
X[which(X$var2 > 8),]

sort(X$var1)
sort(X$var3, decreasing = T)
sort(X$var2, na.last = T)

X[order(X$var1),]
X[order(X$var1, X$var3), ]

library(plyr)
arrange(X, var1)
arrange(X, desc(var1))
X$var4 <- rnorm(5)
Y <- cbind(X, rnorm(5))

# Week 2 ------------------------------------------------------------------
      
##Quiz*************************************************************************

library(httr)
library(jsonlite)
library(dplyr)
myapp <- oauth_app("github", "0be8e869313097c2c325", "fe497b307a10f55868c5a06d038a0283ccc363ea")
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
json1 = content(req)
json2 = jsonlite::fromJSON(toJSON(json1))
subset(json2, name=="datasharing", created_at)

library(sqldf)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv "
download.file(fileUrl, "acs.csv", mode = "wb")
acs <- read.csv("acs.csv")

library(httr)
con <- url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode = readLines(con)
close(con)
nchar(htmlCode)[c(10, 20, 30, 100)]

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
download.file(fileUrl, "data.for")
data <- read.fwf("data.for", skip=4, widths=c(12, 7,4, 9,4, 9,4, 9,4))
sum(data[, 4])


## Reading from APIs***********************************************************

myapp = oauth_app("twitter",
                  key="yourConsumerKeyHere",secret="yourConsumerSecretHere")
sig = sign_oauth1.0(myapp,
                    token = "yourTokenHere",
                    token_secret = "yourTokenSecretHere")
homeTL = GET("https://api.twitter.com/1.1/statuses/home_timeline.json", sig)
json1 = content(homeTL)
json2 = jsonlite::fromJSON(toJSON(json1))
json2[1,1:4]

## Reading from The Web********************************************************
con = url("http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
htmlCode = readLines(con)
close(con)
htmlCode

library(XML)
url <- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html <- htmlTreeParse(url, useInternalNodes=T)
xpathSApply(html, "//title", xmlValue)
xpathSApply(html, "//td[@id='col-citedby']", xmlValue)

library(httr)
html2 = GET(url)
content2 = content(html2,as="text")
parsedHtml = htmlParse(content2,asText=TRUE)
xpathSApply(parsedHtml, "//title", xmlValue)

pg1 = GET("http://httpbin.org/basic-auth/user/passwd")
pg1

pg2 = GET("http://httpbin.org/basic-auth/user/passwd",
          authenticate("user","passwd"))
pg2
names(pg2)

google = handle("http://google.com")
pg1 = GET(handle=google,path="/")
pg2 = GET(handle=google,path="search")

## Reading from HDF5***********************************************************

source("http://bioconductor.org/biocLite.R")
biocLite("rhdf5")
library(rhdf5)

created = h5createFile("example.h5")
created = h5createGroup("example.h5", "foo")
created = h5createGroup("example.h5", "baa")
created = h5createGroup("example.h5", "foo/foobaa")
h5ls("example.h5")

A <- matrix(1:10, nrow=5, ncol=2)
h5write(A, "example.h5", "foo/A")
B <- array(seq(0.1, 2.0, by=0.1), dim=c(5,2,2))
attr(B, "scale") <- "liter"
h5write(B, "example.h5", "foo/foobaa/B")
h5ls("example.h5")

df = data.frame(1L:5L,seq(0,1,length.out=5), 
                c("ab","cde","fghi","a","s"), stringsAsFactors=FALSE)
h5write(df, "example.h5","df")
h5ls("example.h5")

readA <- h5read("example.h5", "foo/A")
readB <- h5read("example.h5", "foo/foobaa/B")
readdf <- h5read("example.h5", "df")
readA

h5write(c(12, 24, 13), "example.h5", "foo/A", index=list(1:3, 2))
h5read("example.h5", "foo/A")

## Reading from MySQL**********************************************************
install.packages("RMySQL")
require(RMySQL)
ucscDb <- dbConnect(MySQL(),user="genome", host="genome-mysql.cse.ucsc.edu")
result <- dbGetQuery(ucscDb,"show databases;")
dbDisconnect(ucscDb)

hg19 <- dbConnect(MySQL(),user="genome", db="hg19", host="genome-mysql.cse.ucsc.edu")
allTables <- dbListTables(hg19)
length(allTables)
allTables[1:5]
dbListFields(hg19,"affyU133Plus2")
dbGetQuery(hg19, "select count(*) from affyU133Plus2")
affyData <- dbReadTable(hg19, "affyU133Plus2")
head(affyData)
query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3")
affyMis <- fetch(query)
quantile(affyMis$misMatches)
affyMisSmall <- fetch(query,n=10)
dbClearResult(query)
dim(affyMisSmall)
dbDisconnect(hg19)

# Week 1 ------------------------------------------------------------------

## Quiz************************************************************************
require(xlsx)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "data.csv")
data <- read.csv("data.csv")
sum <- sum(data$VAL == 24, na.rm = TRUE)

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileUrl, destfile = "data.xlsx",  mode="wb")
colIndex <- 7:15
rowIndex <- 18:23
dat <- read.xlsx("data.xlsx", sheetIndex=1, header=TRUE, colIndex=colIndex,rowIndex=rowIndex)
sum(dat$Zip*dat$Ext,na.rm=T)

require(XML)
fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
doc <- xmlTreeParse(fileUrl, useInternalNodes = TRUE)
rootNode <- xmlRoot(doc)
sum(xpathSApply(rootNode,"//zipcode",xmlValue) == 21231)

require(data.table)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "data.csv")
DT <- fread("data.csv")
c1 <- DT[1]

## data.table******************************************************************

require(data.table)
DF = data.frame(x=rnorm(9),y=rep(c("a","b","c"),each=3),z=rnorm(9))
head(DF, 3)
DT = data.table(x=rnorm(9),y=rep(c("a","b","c"),each=3),z=rnorm(9))
head(DT,3) 
tables()
DT[2, ]
DT[DT$y == "a", ]
DT[c(2,3)]
DT[,c(2,3)]
DT[, list(mean(x), sum(z))]
DT[, table(y)]
DT[, w:=z^2]
DT[, m:={tmp <- (x+z); log2(tmp+5)}]
DT[, a:=x>0]
DT[, b:=mean(x+w), by=a]
set.seed(123)
DT <- data.table(x=sample(letters[1:3], 1E5, TRUE))
DT[, .N, by=x]
DT <- data.table(x=rep(c("a","b","c"),each=100), y=rnorm(300))
setkey(DT, x)
DT['a']
DT1 <- data.table(x=c('a', 'a', 'b', 'dt1'), y=1:4)
DT2 <- data.table(x=c('a', 'b', 'dt2'), z=5:7)
setkey(DT1, x); setkey(DT2, x)
merge(DT1, DT2)


## Reading JSON****************************************************************

require(jsonlite)
jsonData <- fromJSON("https://api.github.com/users/jtleek/repos")
names(jsonData)
names(jsonData$owner)
jsonData$owner$login
myjson <- toJSON(iris, pretty=TRUE)
cat(myjson)
iris2 <- fromJSON(myjson)
      
## Reading XML*****************************************************************

require(XML)
fileUrl <- "http://www.w3schools.com/xml/simple.xml"
doc <- xmlTreeParse(fileUrl, useInternalNodes = TRUE)
rootNode <- xmlRoot(doc)
xmlName(rootNode)
names(rootNode)
rootNode[[1]]
rootNode[[1]][[2]]
xmlSApply(rootNode, xmlValue)
xpathSApply(rootNode, "//name", xmlValue)
xpathSApply(rootNode, "//price", xmlValue)
fileUrl <- "http://espn.go.com/nfl/team/_/name/bal/baltimore-ravens"
doc <- htmlTreeParse(fileUrl, useInternal= TRUE)
scores <- xpathSApply(doc, "//li[@class='score']", xmlValue)
scores <- xpathSApply(doc, "//li[@class='team-name']", xmlValue)

## Reading Excel Files*********************************************************

require(xlsx)
colIndex <- 1:100
rowIndex <- 1:500
file <- read.xlsx("file.xlsx", sheetIndex=1, header=TRUE, colIndex=colIndex,rowIndex=rowIndex)
file1 <- read.xlsx("file.xlsx", sheetIndex=1, header=TRUE, mode="wb")


## Downloading Files***********************************************************

setwd()
getwd()
if(!file.exists("data")) {dir.create("data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile = "data/camers.csv")
list.files("data")