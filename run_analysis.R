library(data.table)
library(dplyr)

# This file implements a project to clean data files, resulting in a "tidy" data set
# summarizing data from a wearable computing project. More information can be found at:

# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
# Of course, one can also look at the other files in the repository where this code
# file is found, namely, CodeBook.md and README.md.

# This function takes two file names, changes the column name to parameter colName,
# and returns a concatenation of file1 and file2. It assumes that each file represents
# a single column of data (this could be modified by changing colName to a vector).
combineChgColName <- function(file1, file2, colName) {
    first <- read.table(file1)
    second <- read.table(file2)
    names(first) <- c(colName)
    names(second) <- c(colName)
    return(rbind(first, second))
}

# We combine the training and test data sets into a single data frame.
train <- read.table("UCIHARDataset/train/X_train.txt", sep = "")
test <- read.table("UCIHARDataset/test/X_test.txt", sep = "")
all <- rbind(train, test)
rm(train, test)

# The feature names are kept in a separate file, so the following code reads that file,
# then finds the features that are measurements of mean or standard deviation.
# The first column contains the numbers of the columns that should be retained in
# our final data set, the second the names of those measurements.
features <- read.table("UCIHARDataset/features.txt")
features.desired <- features[grep("mean\\(|std\\(", features$V2), ]
keepcols <- features.desired$V1
colnames <- features.desired$V2
rm(features, features.desired)

# We do a little simplification of the measurement names. Then we reduce our data set
# to contain only the desired measurements, and change the names.
colnames <- gsub("mean\\(\\)", "mean", colnames)
colnames <- gsub("std\\(\\)", "sd", colnames)
all <- select(all, keepcols)
names(all) <- colnames
rm(keepcols, colnames)

# The IDs of the test subjects and the name of the activities that were measured are
# kept in separate files, and there are separate files for training and test data
# (which we are combining). We call a function to combine the files and change the
# column name to something descriptive.
subject.all <- combineChgColName("UCIHARDataset/train/subject_train.txt", 
                  "UCIHARDataset/test/subject_test.txt", "SubjID")
activ.all <- combineChgColName("UCIHARDataset/train/y_train.txt", 
                               "UCIHARDataset/test/y_test.txt", "ActivName")

# We now have rows with a numeric code for each of the 6 activities that was measured.
# We read the labels for the actvities and read them into a vector.
actlabels <- read.table("UCIHARDataset/activity_labels.txt")
alabelvec <- actlabels[,2]

# We put our three data sets together with Subject ID followed by the Activity ID
# which we then convert to the appropriate string) followed by the combined data (from
# the training and test data sets).
all <- cbind(subject.all, activ.all, all)
all <- mutate(all, ActivName = alabelvec[ActivName])
rm(subject.all, activ.all, actlabels, alabelvec)

# We now have a data frame in which each row has 66 measurements for a combination of 
# Subject ID and Activity ID. We now want to produce a new data set that shows the mean
# of each measurement for each (Subject ID, Activity ID).

# We convert the data frame to a data table (package data.table), then use lapply to
# find the mean of each measurement. This puts the records out of order, so we sort
# them and write the table to a tab-delimited file.
DT <- data.table(all)
DT <- DT[, lapply(.SD, mean), by = c("SubjID", "ActivName")]
DT <- DT[order(as.numeric(DT$SubjID))]
write.table(DT, file = "GCDProject.txt", row.name = FALSE, sep = "\t")
rm(all, DT)
