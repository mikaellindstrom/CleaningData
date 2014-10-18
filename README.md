Readme file for Coursera Getting and Cleaning data course project

# Summary
* The  run_analysis.R script contains all code for creating the tidy output data set.
* The script assumes the files are unzipped in the current working directory keeping the original directory structure from the zipped file, i.e. "UCI HAR Dataset/train" and "UCI HAR Dataset/test" directories each containing the respective files and the common files in the "UCI HAR Dataset" directory.
* The script contains 5 subsections, each doing one of the 5 sub tasks - in order:
1.    Merges the training and the test sets to create one data set.
2.    Extracts only the measurements on the mean and standard deviation for each measurement. 
3.    Uses descriptive activity names to name the activities in the data set
4.    Appropriately labels the data set with descriptive variable names. 
5.    From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
* The script will print out a text prior to executing each subsection to show that it's running and where it is in the execution.

# Setup
Prior to the first section, the plyr and dplyr libraries used in the script are loaded and global variables used throughout the script are defined.

# Section 1 - creating data set

1. Reads in the features, activity labels, subjects, training and test sets from "UCI HAR Dataset" directory
2. binds the subject, training labels and training data into one data frame
3. binds the subject, test labels and test data into one data frame
4. combines the training and test data sets into one set

# Section 2 - Extract required measurements

1. Generates a list of required columns (all columns with std or mean in them) from features data frame
2. Adds subject and activity columsn since they are not part of the features data
3. Creates a subset of just the necessary columns
 
# Section 3 - Rename variables to be more descriptive

1. Replaces the indices in the activity column with the corresponding text from the activity data frame
2. Change the heading from activity index to activity to better reflect the data in that column

# Section 4 - label the data with more human readable names

* Using camel Case notation - a very common variable name notation that is easy to read
* Example: fBodyBodyGyroJerkMag-meanFreq() is renamed to frequencyBodyBodyGyroJerkMagnitudeMeanFrequency

1. Create a temporary list with just the necessary columns
2. Changes each of the column names to be more descriptive by replacing abbreviations with long form and removing - and () to make the labels into camel case
3. Replace the column names in the complete data set

# Section 5 - Create a new data set with the mean for each variable for each subject and activity type.

This generates a table with n+2 columns (n=variable columns with Standard Deviation or mean) and s*a rows 
where s=number of subjects and a=number of activities for each subject

1. Create a new set using ddply and the mean function
2. Replace each column name (apart from subject and activity) with the same name with Mean added to the end of it
3. Write out the table to a file


