### You should create one R script called run_analysis.R that does the following. 
### 1. Merges the training and the test sets to create one data set.
### 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
### 3. Uses descriptive activity names to name the activities in the data set
### 4. Appropriately labels the data set with descriptive variable names. 
### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

library(dplyr)
setwd("C:/Users/Thomas/Documents/UCI HAR Dataset/UCI HAR Dataset")

### import datasets
x_train <- read.table("./train/X_train.txt")
y_train <- read.table("./train/y_train.txt")
train_subjects <- read.table("./train/subject_train.txt")
x_test <- read.table("./test/X_test.txt")
y_test <- read.table("./test/y_test.txt")
test_subjects <- read.table("./test/subject_test.txt")

features <- read.table("./features.txt")
activity_labels <- read.table("./activity_labels.txt")


### label datasets; combine to one dataframe
colnames(x_train) = features[,2]
colnames(y_train) = "ActivityID"
colnames(train_subjects) = "subject_ID"
train_data <- cbind(y_train, train_subjects, x_train)

colnames(x_test) = features[,2]
colnames(y_test) = "ActivityID"
colnames(test_subjects) = "subject_ID"
test_data <- cbind(y_test, test_subjects, x_test)

total_data <- rbind(train_data, test_data)

### extract mean and standard deviation variables
pattern = "mean|std|subject_ID|ActivityID"
subset_data = total_data[,grep(pattern , names(total_data), value=TRUE)]

colnames(activity_labels) = c("ActivityID", "Activity")
final_data <- merge(activity_labels, subset_data, by = "ActivityID")

### more legible variable names
final_clean_data <- gsub("\\(|\\)|-|,", "", colnames(final_data))
colnames(final_data) = final_clean_data

### average of variables by Subject & Activity
TidyData <- final_data %>%
  group_by(subject_ID, Activity) %>%
  summarise_each(funs(mean))

write.table(TidyData, file = "C:/Users/Thomas/Documents/UCI HAR Dataset/UCI HAR Dataset/TidyData.txt", row.names = FALSE)
 
