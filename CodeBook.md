---
title: "CodeBook.md"
output: html_document
---
# CodeBook for **Getting and Cleaning Data** Course Project

This document outlines the variables, data, and transformations that were used to clean
up data from a wearable computing project. A full description of the project that
generated the data can be found at:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data itself is found at:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Approach
In the repository where this file is found, there is a script, run_analysis.R, and a
README.md. The script recreates the steps needed to transform the project data into
the finished product. The README.md gives more details.

The current document will, of necessity, borrow from the original project
documentation.

## Input
The relevant files from the original project are as follows:

- /train/X_train.txt
- /train/subject_train.txt
- /train/y_train.txt
- /test/X_test.txt
- /test/subject_test.txt
- /test/y_test.txt
- /features.txt
- /activity_labels.txt

In each case, the /train files and the /test files have the same format and
purpose, and will be merged into the final file (that is processed to produce
the desired output), so we will treat them the same.

### X_*.txt

These files are the raw data files. They do not contain headings or row
identifiers, they simply contain 561 columns, each with a different physical
measurement (see below) - each row is an observation for a test subject performing one of six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING).

### subject_*.txt

These files consist simply of a column of integers. They each have the same
number of rows as the respective X_*.txt file, and represent the ID of the 
test subject who generated the measurements denoted in that row.

### y_*.txt

Similar to the subject files, each of these is a column of integers. They
represent the numeric ID of the activity.

### features.txt

This file identifies the measurement of each of the columns of data. There are
two columns: the first gives the column number, the second the identifer of
the measurement.

### activity_labels.txt

This file gives the labels for the activities. There are two columns: the first is the activity number, the second the text describing the activity.

## Output

The desired output is a text file that will take the measurements of mean and
standard deviation, and summarize their means by subject and activity. In
other words, since there are 30 subjects and 6 activities, we would expect
180 rows in our output file.

For each of the measurements that we have identified as a mean or standard
deviation (there are 66 of them), we will have a number representing its
mean across the subject/activity pairs.

## Process

The process is well-outlined in the README.md file, and in the comments to
run_analysis.R, so we will be brief here.

Essentially, we put the data back together by appending the row identifiers
(from the subject_*.txt and y_*.txt files), appending the measurement
identifiers (from the features.txt file), converting appropriate identifiers
into more meaningful text, and summarizing the data.

## Measurements

From the project's README.txt file:

>The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

>The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

>For each record it is provided:
>======================================

>- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
>- Triaxial Angular velocity from the gyroscope. 
>- A 561-feature vector with time and frequency domain variables. 
>- Its activity label. 
>- An identifier of the subject who carried out the experiment.

And from the project file features_info.txt:

>Feature Selection 
>=================

>The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

>Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

>Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

>These signals were used to estimate variables of the feature vector for each pattern:  
>'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

>- tBodyAcc-XYZ
>- tGravityAcc-XYZ
>- tBodyAccJerk-XYZ
>- tBodyGyro-XYZ
>- tBodyGyroJerk-XYZ
>- tBodyAccMag
>- tGravityAccMag
>- tBodyAccJerkMag
>- tBodyGyroMag
>- tBodyGyroJerkMag
>- fBodyAcc-XYZ
>- fBodyAccJerk-XYZ
>- fBodyGyro-XYZ
>- fBodyAccMag
>- fBodyAccJerkMag
>- fBodyGyroMag
>- fBodyGyroJerkMag

>The set of variables that were estimated from these signals are: 

>- mean(): Mean value
>- std(): Standard deviation
>- mad(): Median absolute deviation 
>- max(): Largest value in array
>- min(): Smallest value in array
>- sma(): Signal magnitude area
>- energy(): Energy measure. Sum of the squares divided by the number of values. 
>- iqr(): Interquartile range 
>- entropy(): Signal entropy
>- arCoeff(): Autorregresion coefficients with Burg order equal to 4
>- correlation(): correlation coefficient between two signals
>- maxInds(): index of the frequency component with largest magnitude
>- meanFreq(): Weighted average of the frequency components to obtain a mean frequency
>- skewness(): skewness of the frequency domain signal 
>- kurtosis(): kurtosis of the frequency domain signal 
>- bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
>- angle(): Angle between to vectors.

>Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

>- gravityMean
>- tBodyAccMean
>- tBodyAccJerkMean
>- tBodyGyroMean
>- tBodyGyroJerkMean

### Measurements for this project

The last five appear to be means, but they are used on the angle variable, so we
decided to exclude them from this analysis. As a result, we are left with 66
measurements of means and standard deviations, each of which can vary between -1 and 1. They are:

- tBodyAcc-mean()-X
- tBodyAcc-mean()-Y
- tBodyAcc-mean()-Z
- tBodyAcc-std()-X
- tBodyAcc-std()-Y
- tBodyAcc-std()-Z
- tGravityAcc-mean()-X
- tGravityAcc-mean()-Y
- tGravityAcc-mean()-Z
- tGravityAcc-std()-X
- tGravityAcc-std()-Y
- tGravityAcc-std()-Z
- tBodyAccJerk-mean()-X
- tBodyAccJerk-mean()-Y
- tBodyAccJerk-mean()-Z
- tBodyAccJerk-std()-X
- tBodyAccJerk-std()-Y
- tBodyAccJerk-std()-Z
- tBodyGyro-mean()-X
- tBodyGyro-mean()-Y
- tBodyGyro-mean()-Z
- tBodyGyro-std()-X
- tBodyGyro-std()-Y
- tBodyGyro-std()-Z
- tBodyGyroJerk-mean()-X
- tBodyGyroJerk-mean()-Y
- tBodyGyroJerk-mean()-Z
- tBodyGyroJerk-std()-X
- tBodyGyroJerk-std()-Y
- tBodyGyroJerk-std()-Z
- tBodyAccMag-mean()
- tBodyAccMag-std()
- tGravityAccMag-mean()
- tGravityAccMag-std()
- tBodyAccJerkMag-mean()
- tBodyAccJerkMag-std()
- tBodyGyroMag-mean()
- tBodyGyroMag-std()
- tBodyGyroJerkMag-mean()
- tBodyGyroJerkMag-std()
- fBodyAcc-mean()-X
- fBodyAcc-mean()-Y
- fBodyAcc-mean()-Z
- fBodyAcc-std()-X
- fBodyAcc-std()-Y
- fBodyAcc-std()-Z
- fBodyAccJerk-mean()-X
- fBodyAccJerk-mean()-Y
- fBodyAccJerk-mean()-Z
- fBodyAccJerk-std()-X
- fBodyAccJerk-std()-Y
- fBodyAccJerk-std()-Z
- fBodyGyro-mean()-X
- fBodyGyro-mean()-Y
- fBodyGyro-mean()-Z
- fBodyGyro-std()-X
- fBodyGyro-std()-Y
- fBodyGyro-std()-Z
- fBodyAccMag-mean()
- fBodyAccMag-std()
- fBodyBodyAccJerkMag-mean()
- fBodyBodyAccJerkMag-std()
- fBodyBodyGyroMag-mean()
- fBodyBodyGyroMag-std()
- fBodyBodyGyroJerkMag-mean()
- fBodyBodyGyroJerkMag-std()

We then removed the parentheses from these names to make them a bit more readable;
otherwise, they should be understandable to anyone who has looked into this project.

## Final file

So our final file, which is output as GCDProject.txt, contains 180 rows and 68 columns. Each row is a combination of the first two fields:

Field 1: SubjID

This can take on values from 1 through 30, representing the test subject who performed
the actions of the test.

Field 2: ActivName

This can take one of the values:

- WALKING
- WALKING_UPSTAIRS
- WALKING_DOWNSTAIRS
- SITTING
- STANDING
- LAYING

which represent the activity for which measurements were taken.

Fields 3 - 68:

Each of these measurements can take on continuous values between -1 and 1, and are a
subset of the original measurements (means and standard deviations). The final file
contains the mean of each of these measurements by combination of SubjID and
ActivName.

The names of these fields are:

- tBodyAcc-mean-X
- tBodyAcc-mean-Y
- tBodyAcc-mean-Z
- tBodyAcc-sd-X
- tBodyAcc-sd-Y
- tBodyAcc-sd-Z
- tGravityAcc-mean-X
- tGravityAcc-mean-Y
- tGravityAcc-mean-Z
- tGravityAcc-sd-X
- tGravityAcc-sd-Y
- tGravityAcc-sd-Z
- tBodyAccJerk-mean-X
- tBodyAccJerk-mean-Y
- tBodyAccJerk-mean-Z
- tBodyAccJerk-sd-X
- tBodyAccJerk-sd-Y
- tBodyAccJerk-sd-Z
- tBodyGyro-mean-X
- tBodyGyro-mean-Y
- tBodyGyro-mean-Z
- tBodyGyro-sd-X
- tBodyGyro-sd-Y
- tBodyGyro-sd-Z
- tBodyGyroJerk-mean-X
- tBodyGyroJerk-mean-Y
- tBodyGyroJerk-mean-Z
- tBodyGyroJerk-sd-X
- tBodyGyroJerk-sd-Y
- tBodyGyroJerk-sd-Z
- tBodyAccMag-mean
- tBodyAccMag-sd
- tGravityAccMag-mean
- tGravityAccMag-sd
- tBodyAccJerkMag-mean
- tBodyAccJerkMag-sd
- tBodyGyroMag-mean
- tBodyGyroMag-sd
- tBodyGyroJerkMag-mean
- tBodyGyroJerkMag-sd
- fBodyAcc-mean-X
- fBodyAcc-mean-Y
- fBodyAcc-mean-Z
- fBodyAcc-sd-X
- fBodyAcc-sd-Y
- fBodyAcc-sd-Z
- fBodyAccJerk-mean-X
- fBodyAccJerk-mean-Y
- fBodyAccJerk-mean-Z
- fBodyAccJerk-sd-X
- fBodyAccJerk-sd-Y
- fBodyAccJerk-sd-Z
- fBodyGyro-mean-X
- fBodyGyro-mean-Y
- fBodyGyro-mean-Z
- fBodyGyro-sd-X
- fBodyGyro-sd-Y
- fBodyGyro-sd-Z
- fBodyAccMag-mean
- fBodyAccMag-sd
- fBodyBodyAccJerkMag-mean
- fBodyBodyAccJerkMag-sd
- fBodyBodyGyroMag-mean
- fBodyBodyGyroMag-sd
- fBodyBodyGyroJerkMag-mean
- fBodyBodyGyroJerkMag-sd
