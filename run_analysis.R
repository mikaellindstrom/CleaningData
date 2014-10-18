## Getting and Cleaning Data - course project

library(plyr)
library(dplyr)
subject_column<-c("subject")
activity_column<-c("activity")
activity_index<-c("activity_index")

####################################################################################
## 1. Merge the training and test sets to create one data set
print("1. Merge the training and test sets to create one data set")
## read in the data
features<-read.table("UCI HAR Dataset/features.txt", col.names=c("index", "feature"))
activity_labels<-read.table("UCI HAR Dataset/activity_labels.txt",
                            col.names=c(activity_index, activity_column))

## Training set data
subject_train<-read.table("UCI HAR Dataset/train/subject_train.txt", col.names=subject_column)
x_train<-read.table("UCI HAR Dataset/train/X_train.txt")
y_train<-read.table("UCI HAR Dataset/train/Y_train.txt", col.names=activity_index)

train<-cbind(subject_train, y_train, x_train)

## Test set data
subject_test<-read.table("UCI HAR Dataset/test/subject_test.txt", col.names=subject_column)
x_test<-read.table("UCI HAR Dataset/test/X_test.txt")
y_test<-read.table("UCI HAR Dataset/test/Y_test.txt", col.names=activity_index)

test<- cbind(subject_test, y_test, x_test)

# merge sets
complete_set<-rbind(train, test)

####################################################################################
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
print("2. Extracts only the measurements on the mean and standard deviation for each measurement.")
#Generate list of all needed columns
f_std_mean_columns<-grep("std|mean", features$feature)
# Add subject and activity columns
f_std_mean_columns2<-c(1,2,f_std_mean_columns+2)

# only keep wanted columns
complete_set_std_mean<-complete_set[, f_std_mean_columns2]


####################################################################################
## 3. Uses descriptive activity names to name the activities in the data set
# combine labels
print("3. Uses descriptive activity names to name the activities in the data set")
y_train_labels<-join(y_train, activity_labels)[activity_column]
y_test_labels<-join(y_test, activity_labels)[activity_column]
combined_activity_labels<-rbind(y_train_labels, y_test_labels)

# Change to from activity index to activity string
complete_set_std_mean[,activity_index]<-
        activity_labels$activity[complete_set_std_mean$activity_index]

# change heading 
names(complete_set_std_mean)[names(complete_set_std_mean) == activity_index] <- activity_column

####################################################################################
## 4. Appropriately labels the data set with descriptive variable names. 
print("4. Appropriately labels the data set with descriptive variable names.")


f_std_mean<-features[f_std_mean_columns,]

f_std_mean$feature<-factor(gsub("^t", "time", f_std_mean$feature))
f_std_mean$feature<-factor(gsub("^f", "frequency", f_std_mean$feature))
f_std_mean$feature<-factor(gsub("-arCoeff", "AutorregressionCoeffecient", f_std_mean$feature))
f_std_mean$feature<-factor(gsub("-sma", "SignalMagnitudeArea", f_std_mean$feature))
f_std_mean$feature<-factor(gsub("-iqr", "InterquartileRange", f_std_mean$feature))
f_std_mean$feature<-factor(gsub("-m", "M", f_std_mean$feature))
f_std_mean$feature<-factor(gsub("-e", "E", f_std_mean$feature))
f_std_mean$feature<-factor(gsub("-c", "C", f_std_mean$feature))
f_std_mean$feature<-factor(gsub("-s", "S", f_std_mean$feature))
f_std_mean$feature<-factor(gsub("-k", "K", f_std_mean$feature))
f_std_mean$feature<-factor(gsub("-b", "B", f_std_mean$feature))
f_std_mean$feature<-factor(gsub("Mad", "MedianAbsoluteDeviation", f_std_mean$feature))
f_std_mean$feature<-factor(gsub("Mag", "Magnitude", f_std_mean$feature))
f_std_mean$feature<-factor(gsub("Acc", "Acceleration", f_std_mean$feature))
f_std_mean$feature<-factor(gsub("Std", "StandardDeviation", f_std_mean$feature))
f_std_mean$feature<-factor(gsub("MaxInds", "MaxIndex", f_std_mean$feature))
f_std_mean$feature<-factor(gsub("Freq", "Frequency", f_std_mean$feature))
f_std_mean$feature<-factor(gsub("\\(\\)", "", f_std_mean$feature))
f_std_mean$feature<-factor(gsub("-X", "X", f_std_mean$feature))
f_std_mean$feature<-factor(gsub("-Y", "Y", f_std_mean$feature))
f_std_mean$feature<-factor(gsub("-Z", "Z", f_std_mean$feature))


# add subject and activity to column name list and then update data frame
sub_feature_list<-as.character(f_std_mean$feature)
sub_feature_list<-c(subject_column, activity_column, sub_feature_list)
names(complete_set_std_mean)<- sub_feature_list


## 5. From the data set in step 4, creates a second, 
##    independent tidy data set with the average of each variable for
##    each activity and each subject.
print("5.Create 2nd data set with average of each variable for each activity and each subject.")

new_mean_set<-ddply(complete_set_std_mean, .(subject, activity), numcolwise(mean))

new_mean_set_cols<-colnames(new_mean_set)

for(i in 3:length(new_mean_set_cols)) {
    colnames(new_mean_set)[i] <- paste(new_mean_set_cols[i], "Mean", sep="")
}

write.table(new_mean_set, file="outputTidyData.txt", row.name=FALSE)
