# Getting and Cleaning Data - Coursera Project

This is a part of course project Getting and Cleaning Data course on Coursera. All the codes are in R, and the source file is `run_analysis.R`. Here is the description of the R script in the source file:

1. If the dataset does not exist download it first.

a. Has the zip file already been downloaded in `./UCIdata` directory? --Checking--
b. Has the zip file already been unzipped? --Checking--

2. Listing all the files in UCI HAR Dataset folder The files that will be used to load data are listed as follows: `test/subject_test.txt`
`test/X_test.txt`
`test/y_test.txt`
`train/subject_train.txt`
`train/X_train.txt`
`train/y_train.txt`

3. Loading all the necessary files: activity, subject and features info, then reading all data from the files into the variables. Read the Activity files, Subject files, and Features files.

4. Merging the train and the test data sets to create a combined data set.
a. Concatenating the data tables by rows.
b. setting the names to variables.
c. Merging columns to get the data frame for all data.

5. Extracts only the measurements on the mean and standard deviation for each measurement.
a. Subset Name of Features by measurements on the mean and standard deviation.
b. Subset the data frame Data by selected names of Features.

6. Uses descriptive activity names to name the activities in the data set.

a. Read descriptive activity names from `activity_labels.txt`
b. Factorize activity data using descriptive activity names.

7. Appropriately labels the data set with descriptive variable names.

8. Creates a independent tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.

And the final output file is `tidydata.txt`