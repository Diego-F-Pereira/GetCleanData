rm(list=ls())

# Set your working directory
setwd("C:/Users/Diego/Documents/GetAndCleanData")

# Load the features file.
# It is going to be used for filtering mean and standard deviation columns,
# and for labeling column names.

headings.data  <- as.character(read.table("./UCI HAR Dataset/features.txt")[, 2])

# Add the "subject" entry to headings.

headings.data  <- c("subject", "activity", headings.data)

# Create a regex pattern for filtering columns
# and get the column index of those selected.

avg.std.ptrn   <- "mean[^A-Za-z0-9]|std[^A-Za-z0-9]"
avg.std.cols   <- (grep(pattern = avg.std.ptrn, headings.data))

# Partial Cleanning

rm(list = "avg.std.ptrn")

# Fix feature names in order to accomplish R conventions for column names.
headings.data  <- tolower(headings.data)
headings.data  <- gsub("-", ".", headings.data)
headings.data  <- gsub(",", ".", headings.data)
headings.data  <- gsub("\\()", "", headings.data)
headings.data  <- gsub("\\(", ".", headings.data)
headings.data  <- gsub("\\)", "", headings.data)

# Load the test and train datasets, append the subjects and activities
# to each one and merge the resulting data sets into a single one.
# The column names "subject"  and "activity" are specified from the 
# begining in order to avoid a strange collision that happened when 
# merging data frames.
# Need to double-check if this was due corruption in the draft code.

test.data      <- read.table("./UCI HAR Dataset/test/X_test.txt")
test.subj      <- read.table("./UCI HAR Dataset/test/subject_test.txt",
                             col.names = "subject")
test.acti     <- read.table("./UCI HAR Dataset/test/y_test.txt",
                            col.names = "activity")

test.complete  <- cbind(test.subj, test.acti, test.data)

train.data     <- read.table("./UCI HAR Dataset/train/X_train.txt")
train.subj     <- read.table("./UCI HAR Dataset/train/subject_train.txt",
                             col.names = "subject")
train.acti     <- read.table("./UCI HAR Dataset/train/y_train.txt",
                             col.names = "activity")

train.complete <- cbind(train.subj, train.acti, train.data)

# Partial Cleanning

rm(list = "train.data", "train.subj", "train.acti", 
          "test.data", "test.subj", "test.acti")

merged.data    <- merge(test.complete, train.complete, all = TRUE)

# Partial Cleanning

rm(list = "test.complete","train.complete")

# Subset the merged data set into another that contains only
# mean and standard deviation data.

merged.avg.std <- merged.data[, c(1, 2, avg.std.cols)]

# Assign features to column names.

colnames(merged.avg.std) <- headings.data[c(1, 2, avg.std.cols)]

# Partial Cleanning

rm(list = "avg.std.cols", "headings.data")

# Creates the data frame with the average of each variable 
# for each activity and each subject

library(plyr)

avg.activity.subject <- ddply(merged.avg.std, .(subject, activity), numcolwise(mean))

acti.codes     <- read.table("./UCI HAR Dataset/activity_labels.txt")

merged.final   <- merge(avg.activity.subject, acti.codes, by.x = "activity", by.y = "V1")

# Partial Cleanning

rm(list = "acti.codes", "avg.activity.subject")

# Tidy Dataset

tidy.data      <- merged.final[,2:69]

colnames(tidy.data)[68] <- "activity"

# Final Cleaning

rm(list = "merged.final")

# Exports the tidy data frame to a tab delimited file

write.table(tidy.data, "./tidy.txt", sep="\t")

