
# load necessary libraries
library(dplyr)
library(data.table)
library(reshape2)

# download the files
path = getwd()
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
              file.path(path, "dataFile.zip"))
unzip(zipfile = "dataFile.zip")


# main objective: merge the training and test sets to create one data set
## Load files from the dataFile

activityLabel <-fread("UCI HAR Dataset/activity_labels.txt",
                      col.names = c("classLabels","activityName"))

features <- fread("UCI HAR Dataset/features.txt",
                  col.names= c("index", "featureNames"))
## get the standard deviation or mean features
mean_sd_features<- grep("(mean|std)\\(\\)", features$featureNames)
measurements <- features[mean_sd_features, featureNames]
## clean the data
measurements <- gsub('[()]', '', measurements)

# load test data and create one large test table
test_subject <- fread("UCI HAR Dataset/test/subject_test.txt",
               col.names = c("SubjectNumber"))
test_x <- fread("UCI HAR Dataset/test/X_test.txt")[, mean_sd_features, with = FALSE]
#replace test 2 columns names with measurements 
setnames(test_x, names(test_x), measurements)
test_activity <- fread("UCI HAR Dataset/test/y_test.txt",
              col.names= c("Activity"))
all_test <- cbind(test_subject,test_x,test_activity)

# load train data and create one large train table
train1_subject <- fread("UCI HAR Dataset/train/subject_train.txt",
               col.names = c("SubjectNumber"))
train_x <- fread("UCI HAR Dataset/train/X_train.txt")[, mean_sd_features, with = FALSE]
#replace test 2 columns names with measurements 
setnames(train_x, names(train_x), measurements)
train_activity <- fread("UCI HAR Dataset/train/y_train.txt",
                        col.names = c("Activity"))
all_train <- cbind(train1_subject, train_x, train_activity)

# merge datasets
merged_df <- rbind(all_test, all_train)

# change the activity code to activity name
merged_df[["Activity"]] <- factor(merged_df[, Activity]
                                 , levels = activityLabel[["classLabels"]]
                                 , labels = activityLabel[["activityName"]])

# wide data column to long format data using reshape2 melt
merged_df <- reshape2::melt(data = merged_df, id = c("SubjectNumber", "Activity"))
merged_df <- reshape2::dcast(data = merged_df, SubjectNumber + Activity ~ variable, fun.aggregate = mean)

# from the dataset in previous step, create a second, independent tidy data set
## with the average of each avtivity and each subject

data.table::fwrite(x = merged_df, file = "tidyData.txt", quote = FALSE)





