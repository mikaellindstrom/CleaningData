## Getting and Cleaning Data - course project

library(plyr)
library(dplyr)
subjectColumn<-c("subject")
activityColumn<-c("activity")
activityIndex<-c("activityIndex")

####################################################################################
## 1. Merge the training and test sets to create one data set
print("1. Merge the training and test sets to create one data set")
## read in the data
features<-read.table("UCI HAR Dataset/features.txt", col.names=c("index", "feature"))
activityLabels<-read.table("UCI HAR Dataset/activity_labels.txt",
                            col.names=c(activityIndex, activityColumn))

## Training set data
subjectTrain<-read.table("UCI HAR Dataset/train/subject_train.txt", col.names=subjectColumn)
xTrain<-read.table("UCI HAR Dataset/train/x_train.txt")
yTrain<-read.table("UCI HAR Dataset/train/y_train.txt", col.names=activityIndex)

train<-cbind(subjectTrain, yTrain, xTrain)

## Test set data
subjectTest<-read.table("UCI HAR Dataset/test/subject_test.txt", col.names=subjectColumn)
xTest<-read.table("UCI HAR Dataset/test/x_test.txt")
yTest<-read.table("UCI HAR Dataset/test/y_test.txt", col.names=activityIndex)

test<- cbind(subjectTest, yTest, xTest)

# merge sets
completeSet<-rbind(train, test)

####################################################################################
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
print("2. Extracts only the measurements on the mean and standard deviation for each measurement.")
#Generate list of all needed columns
fStdMeanColumns<-grep("std|mean", features$feature)
# Add subject and activity columns
fStdMeanColumns2<-c(1,2,fStdMeanColumns+2)

# only keep wanted columns
completeSetStdMean<-completeSet[, fStdMeanColumns2]


####################################################################################
## 3. Uses descriptive activity names to name the activities in the data set
# combine labels
print("3. Uses descriptive activity names to name the activities in the data set")
yTrainLabels<-join(yTrain, activityLabels)[activityColumn]
yTestLabels<-join(yTest, activityLabels)[activityColumn]

# Change to from activity index to activity string
completeSetStdMean[,activityIndex]<-
        activityLabels$activity[completeSetStdMean$activityIndex]

# change heading 
names(completeSetStdMean)[names(completeSetStdMean) == activityIndex] <- activityColumn

####################################################################################
## 4. Appropriately labels the data set with descriptive variable names. 
print("4. Appropriately labels the data set with descriptive variable names.")


fStdMean<-features[fStdMeanColumns,]

fStdMean$feature<-factor(gsub("^t", "time", fStdMean$feature))
fStdMean$feature<-factor(gsub("^f", "frequency", fStdMean$feature))
fStdMean$feature<-factor(gsub("-arCoeff", "AutorregressionCoeffecient", fStdMean$feature))
fStdMean$feature<-factor(gsub("-sma", "SignalMagnitudeArea", fStdMean$feature))
fStdMean$feature<-factor(gsub("-iqr", "InterquartileRange", fStdMean$feature))
fStdMean$feature<-factor(gsub("-m", "M", fStdMean$feature))
fStdMean$feature<-factor(gsub("-e", "E", fStdMean$feature))
fStdMean$feature<-factor(gsub("-c", "C", fStdMean$feature))
fStdMean$feature<-factor(gsub("-s", "S", fStdMean$feature))
fStdMean$feature<-factor(gsub("-k", "K", fStdMean$feature))
fStdMean$feature<-factor(gsub("-b", "B", fStdMean$feature))
fStdMean$feature<-factor(gsub("Mad", "MedianAbsoluteDeviation", fStdMean$feature))
fStdMean$feature<-factor(gsub("Mag", "Magnitude", fStdMean$feature))
fStdMean$feature<-factor(gsub("Acc", "Acceleration", fStdMean$feature))
fStdMean$feature<-factor(gsub("Std", "StandardDeviation", fStdMean$feature))
fStdMean$feature<-factor(gsub("MaxInds", "MaxIndex", fStdMean$feature))
fStdMean$feature<-factor(gsub("Freq", "Frequency", fStdMean$feature))
fStdMean$feature<-factor(gsub("\\(\\)", "", fStdMean$feature))
fStdMean$feature<-factor(gsub("-X", "X", fStdMean$feature))
fStdMean$feature<-factor(gsub("-Y", "Y", fStdMean$feature))
fStdMean$feature<-factor(gsub("-Z", "Z", fStdMean$feature))


# add subject and activity to column name list and then update data frame
subFeatureList<-as.character(fStdMean$feature)
subFeatureList<-c(subjectColumn, activityColumn, subFeatureList)
names(completeSetStdMean)<- subFeatureList


## 5. From the data set in step 4, creates a second, 
##    independent tidy data set with the average of each variable for
##    each activity and each subject.
print("5.Create 2nd data set with average of each variable for each activity and each subject.")

newMeanSet<-ddply(completeSetStdMean, .(subject, activity), numcolwise(mean))

newMeanSetCols<-colnames(newMeanSet)

for(i in 3:length(newMeanSetCols)) {
    colnames(newMeanSet)[i] <- paste(newMeanSetCols[i], "Mean", sep="")
}

write.table(newMeanSet, file="outputTidyData.txt", row.name=FALSE)
