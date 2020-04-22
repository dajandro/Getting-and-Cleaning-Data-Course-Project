# LOAD LIBRARIES
library(dplyr)
library(reshape2)

# SET WORKING DIRECTORY
setwd("~/CMIA/Cursos/Coursera - Data Scientist Specialization/Course 3/UCI HAR Dataset")

# Merge the training and the test sets to create one data set
  ## READ FEATURES FILE
  if(!file.exists("features.txt")) message("Features file doesn't exists")
  features <- read.csv("features.txt", sep = "", header=F)
  colnames(features) <- c("ID","FEATURE")
  
  ## READ ACTIVITY LABELS
  if(!file.exists("activity_labels.txt")) message("Activity labels file doesn't exists")
  activity_labels <- read.csv("activity_labels.txt", sep = "", header=F)
  colnames(activity_labels) <- c("ID","ACTIVITY")

  ## READ TRAINING FILES
  if(!file.exists("train/X_train.txt")) message("Train set file doesn't exists")
  if(!file.exists("train/y_train.txt")) message("Train labels set file doesn't exists")
  if(!file.exists("train/subject_train.txt")) message("Train subjects set file doesn't exists")
  train <- read.table("train/X_train.txt")
  train_labels <- read.table("train/y_train.txt", col.names = c("ACTIVITY_ID"))
  train_subjects <- read.table("train/subject_train.txt", col.names = c("SUBJECT_ID"))
  train <- cbind(train, "ACTIVITY_ID"=train_labels$ACTIVITY_ID)
  train <- cbind(train, "SUBJECT_ID"=train_subjects$SUBJECT_ID)

  ## READ TEST FILES
  if(!file.exists("test/X_test.txt")) message("Test set file doesn't exists")
  if(!file.exists("test/y_test.txt")) message("Test labels set file doesn't exists")
  if(!file.exists("test/subject_test.txt")) message("Test subjects set file doesn't exists")
  test <- read.table("test/X_test.txt")
  test_labels <- read.table("test/y_test.txt", col.names = c("ACTIVITY_ID"))
  test_subjects <- read.table("test/subject_test.txt", col.names = c("SUBJECT_ID"))
  test <- cbind(test, "ACTIVITY_ID"=test_labels$ACTIVITY_ID)
  test <- cbind(test, "SUBJECT_ID"=test_subjects$SUBJECT_ID)
  
  ## MERGE TRAIN AND TEST
  set <- rbind(train,test)

# Extract only the measurements on the mean and standard deviation for each measurement.
  ## SELECT FEATURES BY REGEX PATTERN
  mean_std_features <- grepl("*-(mean|std)[(][)]-*",features$FEATURE)
  ## SUBSET MEASUREMENTS
  set <- set[,mean_std_features]

# Use descriptive activity names to name the activities in the data set
  set <- merge(set, activity_labels, by.x = "ACTIVITY_ID", by.y = "ID")
  
# Appropriately labels the data set with descriptive variable names.
  colnames(set) <- c("ACTIVITY_ID",as.character(features$FEATURE[mean_std_features==T]),"SUBJECT_ID","ACTIVITY")
  
# Create a second, independent tidy data set with the average of each variable for each activity and each subject.
  ## MELT DATA
  tidy_set <- melt(set, id.vars = c("ACTIVITY_ID","ACTIVITY","SUBJECT_ID"))
  ## GROUP AND SUMMARIZE
  tidy_set <- tidy_set %>% group_by(ACTIVITY, SUBJECT_ID, variable) %>% summarise(AVERAGE=mean(value)) %>% rename(VARIABLE=variable)
  
write.csv(tidy_set, "tidy_set.csv", row.names = F)
