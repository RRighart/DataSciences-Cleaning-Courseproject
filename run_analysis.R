## LOAD DATA

# train
setwd("/home/righart/Documents/prs/Coursera-DataSciences-Cleaning/project/UCI HAR Dataset/train/")
subject_train <- read.table("subject_train.txt", sep="",na.string="NA", col.names=c("subjects"))
X_train <- read.table("X_train.txt",header=FALSE, sep="",na.string="NA") #7352x561
y_train <- read.table("y_train.txt",header=FALSE, sep="",na.string="NA", col.names=c("activity_labels")) #7352x1

# test
setwd("/home/righart/Documents/prs/Coursera-DataSciences-Cleaning/project/UCI HAR Dataset/test/")
subject_test <- read.table("/home/righart/Documents/prs/Coursera-DataSciences-Cleaning/project/UCI HAR Dataset/test/subject_test.txt", sep="",na.string="NA", col.names=c("subjects"))
X_test <- read.table("X_test.txt",header=FALSE,sep="",na.string="NA") #2947x561
y_test <- read.table("y_test.txt",header=FALSE,sep="",na.string="NA", col.names=c("activity_labels")) #2947x1

## 1. MERGE TRAINING AND TEST SET TO CREATE ONE DATASET

tset <- rbind(X_train, X_test) #merges training and testset
subjects <- rbind(subject_train, subject_test) #merges the subject variable
activity <- rbind(y_train, y_test) #merges the activity variable

## 2. EXTRACT ONLY THE MEASURES ON THE MEAN AND SD FOR EACH MEASUREMENT

FT<- read.table("/home/righart/Documents/prs/Coursera-DataSciences-Cleaning/project/UCI HAR Dataset/features.txt") #first the feature list is read to put in the names for each variable

pattern<-"mean|std" #the pattern match is saved in a vector
x<-grep(pattern,FT[ ,2]) #pattern is used to search through the variables for terms that match "mean" or "std"

nFT<-FT[x,2] #selection of variable names based on the vector x
ntset<-tset[ ,x] #selection of variables based on the vector x

## 3. DESCRIPTIVE ACTIVITY NAMES

activity_labels <- factor(activity[ ,1], levels = c(1,2,3,4,5,6), labels = c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING", "STANDING", "LAYING")) #the values of the activity vector are replaced by the appropriate label

## 4. DATASET LABELED WITH DESCRIPTIVE VARIABLE NAMES

names(ntset) <- nFT #naming variables

final_set <- cbind(subjects, ntset, activity_labels)

## 5. CREATION OF SECOND INDEPENDENT TIDY DATASET

library(plyr)

tidyset<-ddply(final_set, .(final_set$subjects, final_set$activity_labels), colwise(mean)) #creates mean values as a function of subject and activity levels resulting in a tidy dataset with 30x6=180 rows and 81 columns.

setwd("/home/righart/Documents/prs/Coursera-DataSciences-Cleaning/project/")
write.table(tidyset, file="tidydata.txt", row.name=FALSE) #write out dataset as table

