# Script: run_analysis.R
# Written by: James Pederson
# Last modified: 29-Jan-2017
# Getting and Cleaning Data Course Project - This script will demonstrate a working
#     understanding of the concepts learned in the course.

# Source the plyr library

library(plyr)
library(knitr)

# Set working directory
setwd("C:\\Users\\James\\Desktop\\Coursera\\3 - Getting and Cleaning Data\\Course Project")

# Set URL and download dataset.zip
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url,destfile="./dataset.zip")

# Unzip file: dataset.zip
unzip(zipfile="dataset.zip")

# Read the files

testActivity <- read.table("C:\\Users\\James\\Desktop\\Coursera\\3 - Getting and Cleaning Data\\Course Project\\UCI HAR Dataset\\test\\Y_test.txt",header = FALSE)
testSubject <- read.table("C:\\Users\\James\\Desktop\\Coursera\\3 - Getting and Cleaning Data\\Course Project\\UCI HAR Dataset\\test\\subject_test.txt",header = FALSE)
testFeatures <- read.table("C:\\Users\\James\\Desktop\\Coursera\\3 - Getting and Cleaning Data\\Course Project\\UCI HAR Dataset\\test\\X_test.txt",header = FALSE)

trainActivity <- read.table("C:\\Users\\James\\Desktop\\Coursera\\3 - Getting and Cleaning Data\\Course Project\\UCI HAR Dataset\\train\\Y_train.txt",header = FALSE)
trainSubject <- read.table("C:\\Users\\James\\Desktop\\Coursera\\3 - Getting and Cleaning Data\\Course Project\\UCI HAR Dataset\\train\\subject_train.txt",header = FALSE)
trainFeatures <- read.table("C:\\Users\\James\\Desktop\\Coursera\\3 - Getting and Cleaning Data\\Course Project\\UCI HAR Dataset\\train\\X_train.txt",header = FALSE)

features <- read.table("C:\\Users\\James\\Desktop\\Coursera\\3 - Getting and Cleaning Data\\Course Project\\UCI HAR Dataset\\features.txt",head=FALSE)
activities <- read.table("C:\\Users\\James\\Desktop\\Coursera\\3 - Getting and Cleaning Data\\Course Project\\UCI HAR Dataset\\activity_labels.txt",header = FALSE)

# Merge the datasets

subjectData <- rbind(trainSubject, testSubject)
activityData <- rbind(trainActivity, testActivity)
featuresData <- rbind(trainFeatures, testFeatures)

names(subjectData) <- c("subject")
names(activityData) <- c("activity")
names(featuresData) <- features$V2

mergedData <- cbind(subjectData, activityData)
data <- cbind(featuresData, mergedData)

# Subset the data and extract measurements on the mean and standard deviation for each measurement

featuresNames <- features$V2[grep("mean\\(\\)|std\\(\\)", features$V2)]

selectedNames <- c(as.character(featuresNames), "subject", "activity" )
data <- subset(data,select=selectedNames)

# Global subtitute to use descriptive names

names(data)<-gsub("^t", "time", names(data))
names(data)<-gsub("^f", "frequency", names(data))
names(data)<-gsub("Acc", "Accelerometer", names(data))
names(data)<-gsub("Gyro", "Gyroscope", names(data))
names(data)<-gsub("Mag", "Magnitude", names(data))
names(data)<-gsub("BodyBody", "Body", names(data))

# Create final tidy data set

tidyData<-aggregate(. ~subject + activity, data, mean)
tidyData<-tidyData[order(tidyData$subject,tidyData$activity),]
write.table(tidyData, file = "tidyData.txt",row.name=FALSE)