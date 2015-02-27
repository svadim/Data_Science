library(dplyr)

# Download the data
if(!file.exists("data/UCI HAR Dataset.zip")) {
      dir.create("data")
      url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
      download.file(url, "data/UCI HAR Dataset.zip")}
unzip("data/UCI HAR Dataset.zip", exdir="data")
work_dir <- getwd()
setwd("data/UCI HAR Dataset")

# Read the data
activity_name <- read.table("activity_labels.txt")[,2] ## Names of activities
feature_name <- read.table("features.txt")[,2] ## Names of features
test_set <- read.table("test/X_test.txt") ## Test set
test_lab <- read.table("test/y_test.txt") ## Test labels
test_sub <- read.table("test/subject_test.txt") ## Subjects
train_set <- read.table("train/X_train.txt") ## Training set
train_lab <- read.table("train/y_train.txt") ## Training labels
train_sub <- read.table("train/subject_train.txt") ## Subjects

# Merge the training and the test sets
set <- rbind(test_set, train_set)
label <- rbind(test_lab, train_lab)[,1]
subject <- rbind(test_sub, train_sub)[,1]

# Add the variable names to the dataset
# Extract only the mean and standard deviation measurements 
colnames(set) <- feature_name
mean <- grepl("mean\\()", colnames(set))
std <- grepl("std\\()", colnames(set))
data <- cbind(set[mean], set[std])

# Add the activity names and the subject to the dataset
activity <- factor(x=label, labels=activity_name)
subject <- factor(subject)
data_tidy <- cbind(subject, activity, data)

# Clean up the columns names
col_names <- names(data_tidy)
col_names <- tolower(col_names)
col_names <- gsub("-", ".", col_names)
col_names <- gsub("\\()", "", col_names)
col_names <- gsub("bodybody|body", "body", col_names)
colnames(data_tidy) <- col_names

# Find the mean for each variable for each subject and activity 
data_avarage <- data_tidy %>% 
      group_by(subject, activity) %>% 
      summarise_each(funs(mean))

# Write the summary data to a text file
setwd(work_dir)
file_name <- paste("data/result_", Sys.Date(), ".txt", sep="")
write.table(data_avarage, file_name, row.name=FALSE)

# Clean up workspace
rm(list=ls())