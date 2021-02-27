##FOR MERGING. 1. Merges the training and the test sets to create one data set.
##package needed
library(dplyr)

##Downloading data
if(!file.exists("./UCIdata")){dir.create("./UCIdata")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./UCIdata/UCIHRDataset.zip",method="curl")

##unziping the data
unzip(zipfile = "./UCIdata/UCIHRDataset.zip", exdir = "./UCIdata")

##The following codes are to be used to get a list of the files in the folder
listingfiles_path<- file.path("./UCIdata", "UCI HAR Dataset")
files<- list.files(listingfiles_path, recursive = TRUE)
files


##The following codes are for reading data from files into the variables
activityTest_data<- read.table(file.path(listingfiles_path, "test", "Y_test.txt"), header = FALSE)
activityTrain_data<- read.table(file.path(listingfiles_path, "train", "Y_train.txt"), header = FALSE)

subjectTest_data<- read.table(file.path(listingfiles_path, "test", "subject_test.txt"), header = FALSE)
subjectTrain_data<- read.table(file.path(listingfiles_path, "train", "subject_train.txt"), header = FALSE)

featuresTest_data<- read.table(file.path(listingfiles_path, "test", "X_test.txt"), header = FALSE)
featuresTrain_data<- read.table(file.path(listingfiles_path, "train", "X_train.txt"), header = FALSE)

##Check all the above
str(activityTest_data)
str(activityTrain_data)
str(subjectTest_data)
str(subjectTrain_data)
str(featuresTest_data)
str(featuresTrain_data)


##Merging the data
##Stage 1: Concantenating
Subject_data<- rbind(subjectTrain_data, subjectTest_data)
Activity_data<- rbind(activityTrain_data, activityTest_data)
Features_data<- rbind(featuresTrain_data, featuresTest_data)

##Stage2: Naming teh variables
names(Subject_data)<- c("subject")
names(Activity_data)<- c("activity")
names_for_features<- read.table(file.path(listingfiles_path, "features.txt"), head= FALSE)
names(Features_data)<- names_for_features$V2

##Stage 3: Combining
merged_data<- cbind(Subject_data, Activity_data)
full_mergeddata<- cbind(Features_data, merged_data)




##2. Extracts only the measurements on the mean and standard deviation for each measurement
##a. subset features' names by M and SD
features_subset<- names_for_features$V2[grep("mean\\(\\)|std\\(\\)", names_for_features$V2)]
featuresselected<- c(as.character(features_subset), "subject", "activity")
full_mergeddata<- subset(full_mergeddata, select = featuresselected)
str(full_mergeddata)



##3. Uses descriptive activity names to name the activities in the data set
Label_activity<- read.table(file.path(listingfiles_path, "activity_labels.txt"), header= FALSE)
full_mergeddata$activity<- factor(full_mergeddata$activity, labels = Label_activity[,2])
head(full_mergeddata$activity, 30)



##4. Appropriately labels the data set with descriptive variable names. 
names(full_mergeddata)<- gsub("^t", "time", names(full_mergeddata))
names(full_mergeddata)<- gsub("^f", "frequency", names(full_mergeddata))
names(full_mergeddata)<- gsub("Acc", "Accelorometer", names(full_mergeddata))
names(full_mergeddata)<- gsub("Gyro", "Gyroscope", names(full_mergeddata))
names(full_mergeddata)<- gsub("Mag", "Magnitude", names(full_mergeddata))
names(full_mergeddata)<- gsub("BodyBody", "Body", names(full_mergeddata))
names(full_mergeddata)


##5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
library(plyr)
full_mergeddata_2<- aggregate(. ~subject + activity, full_mergeddata, mean)
full_mergeddata_2<- full_mergeddata_2[order(full_mergeddata_2$subject, full_mergeddata_2$activity),]
write.table(full_mergeddata_2, file = "tidydata.txt", row.names = FALSE)
