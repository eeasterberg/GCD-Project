---
title: "README.md"
output: html_document
---

This file serves a reference to the **Getting and Cleaning Data** course project. It
should be read in conjunction with two other files also held in its repository.

The R script, run_analysis.R, can be run with the data files in appropriate
directories, and will produce the desired output (GCDProject.txt) in the R working
directory.

The Markdown file, CodeBook.md, contains detailed information about the project and
the data fields in the inputs and output.

## Background

The purpose of this project is to clean up a data set from a wearable computing
project. The best source for the background comes from the original data collection
team:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data itself is found at:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Inputs

The files that are processed for this project are (relative to the UCIHARDataset
directory under the R working directory:

- /train/X_train.txt
- /train/subject_train.txt
- /train/y_train.txt
- /test/X_test.txt
- /test/subject_test.txt
- /test/y_test.txt
- /features.txt
- /activity_labels.txt

These files are described in greater detail in CodeBook.md.

## Processing

The best place to see how the processing of the files is in run_analysis.R, the R
script that recreates the work. Here one will find commented code that delineates
what is being done.

However, we will give an outline here.

The requirements for this project are:

> You should create one R script called run_analysis.R that does the following. 

> 1. Merges the training and the test sets to create one data set.

> 2. Extracts only the measurements on the mean and standard deviation for each measurement.

> 3. Uses descriptive activity names to name the activities in the data set

> 4. Appropriately labels the data set with descriptive variable names. 

> 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

And this is pretty much the process followed here. There are three files that represent
the training and test sets: X_\*.txt contains the raw data, y_\*.txt contains a code
for the activity that generated the measurements in the corresponding row of the raw
data, and subject_\*.txt contains the identifier for the test subject on whom the
measurements were made. In each case, those files are merged (requirement 1).

Then, the three merged files are combined into one data set, and the code for the
activity is replaced with the string (using activity_labels.txt) that defines the activity (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
(requirement 3).

A manual examination of the measurements (from features.txt) was performed to identify
those that represented means or standard deviations. The data set was reduced to just
those measurements (requirement 2), and a slightly modified version of the field names
was used to label the columns (requirement 4).

At this point, the data set was reduced so that there was an entry for the mean of
each of the measurements for each combination of test subject and activity
(requirement 5).

## Output

The output of this process is GCDProject.txt, a tab-delimited file with each
combination of subject and activity (there are 30 test subjects and 6 activities, so
180 rows). For each, there is a row of measurements, one each for the fields
identified as means or standard deviations. In each case, the mean of the field is
taken.

If one desires to read the output file into an R data frame, the easiest way is
probably a call to
read.table():

`GCD <- read.table("GCDProject.txt", header = TRUE, sep = "\t")`