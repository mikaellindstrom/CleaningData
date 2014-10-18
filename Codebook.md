# This is the codebook for the Getting and Cleaning data course project

# The Data
From the original website where the data comes from [http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones]:

"Data Set Information:

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years.
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing
a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 
3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been 
video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, 
where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in 
fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, 
which has gravitational and body motion components, was separated using a Butterworth low-pass filter into 
body acceleration and gravity. The gravitational force is assumed to have only low frequency components, 
therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by 
calculating variables from the time and frequency domain.
"

The source data contains for each record in the dataset it is provided:
* Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
* Triaxial Angular velocity from the gyroscope.
* A 561-feature vector with time and frequency domain variables.
* Its activity label.
* An identifier of the subject who carried out the experiment.

features - a data frame / file with all data column names
activity_labels - a data frame / file with all 6 activity types in plain English
subject_train - a data frame / file with the subject identifier for the training set (one row for each row in the training set)
x_train - a data frame / file with the data for the training set
y_train - a data frame / file with the activity type index (i.e. 1:6) for each row in the training set.

subject_test - a data frame / file with the subject identifier for the test set (one row for each row in the test set)
x_test - a data frame / file with the data for the test set
y_test - a data frame / file with the activity type index (i.e. 1:6) for each row in the test set.


# Transformations

* merged the training and test sets to create one data frame with variables for the subject, activity, 
and one variable for each of the individual data items. I.e. 1+2+561 columns
  * Training set contains 7352 rows
  * Test set contains 2947 rows
  * complete set contains 7352+2947=10299 rows
*  Removed all columns that were not mean or standard deviation for each measurement. I.e. 79 columns (plus subject and activity) remained
* Added descriptive activity names, i.e. replaced the index with the corresponding English text
* Replaced the abbreviated measurement variable column names with long form in camelCase notation to make them easy to read
* Created a new data set that is a summary of the previously created set. See below for description of this data set.
* This dataset is written to file in the current working directory.



## The output tidy data file contains 81 columns as listed below.
* subject - an numeric value representing a single subject in the test
* activity - a string representing the activity type
* remaining variables are the means for each of the original columns (see above link for more details) per subject and for each activity type.
* The number of rowas are the number of subjects times the number of activities

subject
activity
timeBodyAccelerationMeanXMean
timeBodyAccelerationMeanYMean
timeBodyAccelerationMeanZMean
timeBodyAccelerationStandardDeviationXMean
timeBodyAccelerationStandardDeviationYMean
timeBodyAccelerationStandardDeviationZMean
timeGravityAccelerationMeanXMean
timeGravityAccelerationMeanYMean
timeGravityAccelerationMeanZMean
timeGravityAccelerationStandardDeviationXMean
timeGravityAccelerationStandardDeviationYMean
timeGravityAccelerationStandardDeviationZMean
timeBodyAccelerationJerkMeanXMean
timeBodyAccelerationJerkMeanYMean
timeBodyAccelerationJerkMeanZMean
timeBodyAccelerationJerkStandardDeviationXMean
timeBodyAccelerationJerkStandardDeviationYMean
timeBodyAccelerationJerkStandardDeviationZMean
timeBodyGyroMeanXMean
timeBodyGyroMeanYMean
timeBodyGyroMeanZMean
timeBodyGyroStandardDeviationXMean
timeBodyGyroStandardDeviationYMean
timeBodyGyroStandardDeviationZMean
timeBodyGyroJerkMeanXMean
timeBodyGyroJerkMeanYMean
timeBodyGyroJerkMeanZMean
timeBodyGyroJerkStandardDeviationXMean
timeBodyGyroJerkStandardDeviationYMean
timeBodyGyroJerkStandardDeviationZMean
timeBodyAccelerationMagnitudeMeanMean
timeBodyAccelerationMagnitudeStandardDeviationMean
timeGravityAccelerationMagnitudeMeanMean
timeGravityAccelerationMagnitudeStandardDeviationMean
timeBodyAccelerationJerkMagnitudeMeanMean
timeBodyAccelerationJerkMagnitudeStandardDeviationMean
timeBodyGyroMagnitudeMeanMean
timeBodyGyroMagnitudeStandardDeviationMean
timeBodyGyroJerkMagnitudeMeanMean
timeBodyGyroJerkMagnitudeStandardDeviationMean
frequencyBodyAccelerationMeanXMean
frequencyBodyAccelerationMeanYMean
frequencyBodyAccelerationMeanZMean
frequencyBodyAccelerationStandardDeviationXMean
frequencyBodyAccelerationStandardDeviationYMean
frequencyBodyAccelerationStandardDeviationZMean
frequencyBodyAccelerationMeanFrequencyXMean
frequencyBodyAccelerationMeanFrequencyYMean
frequencyBodyAccelerationMeanFrequencyZMean
frequencyBodyAccelerationJerkMeanXMean
frequencyBodyAccelerationJerkMeanYMean
frequencyBodyAccelerationJerkMeanZMean
frequencyBodyAccelerationJerkStandardDeviationXMean
frequencyBodyAccelerationJerkStandardDeviationYMean
frequencyBodyAccelerationJerkStandardDeviationZMean
frequencyBodyAccelerationJerkMeanFrequencyXMean
frequencyBodyAccelerationJerkMeanFrequencyYMean
frequencyBodyAccelerationJerkMeanFrequencyZMean
frequencyBodyGyroMeanXMean
frequencyBodyGyroMeanYMean
frequencyBodyGyroMeanZMean
frequencyBodyGyroStandardDeviationXMean
frequencyBodyGyroStandardDeviationYMean
frequencyBodyGyroStandardDeviationZMean
frequencyBodyGyroMeanFrequencyXMean
frequencyBodyGyroMeanFrequencyYMean
frequencyBodyGyroMeanFrequencyZMean
frequencyBodyAccelerationMagnitudeMeanMean
frequencyBodyAccelerationMagnitudeStandardDeviationMean
frequencyBodyAccelerationMagnitudeMeanFrequencyMean
frequencyBodyBodyAccelerationJerkMagnitudeMeanMean
frequencyBodyBodyAccelerationJerkMagnitudeStandardDeviationMean
frequencyBodyBodyAccelerationJerkMagnitudeMeanFrequencyMean
frequencyBodyBodyGyroMagnitudeMeanMean
frequencyBodyBodyGyroMagnitudeStandardDeviationMean
frequencyBodyBodyGyroMagnitudeMeanFrequencyMean
frequencyBodyBodyGyroJerkMagnitudeMeanMean
frequencyBodyBodyGyroJerkMagnitudeStandardDeviationMean
frequencyBodyBodyGyroJerkMagnitudeMeanFrequencyMean
