
x_train, y_train, x_test, y_test, train_subject, subject_test, features, activity_labels are 
from Samsung S Smartphone accelerometers datasets downloadable here: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

train_data merges x_train, y_train, subject_train

test_data merges x_test, y_test, test_subject

total_data merges train_data and test_data

subset_data filters out variables not relevant to mean or standard deviation metrics

final_data adds descriptive activity labels to subset_data

final_clean_data cleans up variable names

TidyData averages variables by Subject_ID and Activity
