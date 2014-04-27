rm(list=ls())

# Set your working directory
#   setwd("Your Path")

# Load the features file.
# It is going to be used for filtering mean and standard deviation columns,
# and for labeling column names.

headings.data  <- as.character(read.table("./UCI HAR Dataset/features.txt")[, 2])

# Add the "subject" entry to headings.

headings.data  <- c("subject", headings.data)

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

# Load the test and train datasets, append the subjects to each one 
# and merge the resulting data sets into a single one.
# The column name "subject" is specified from the begining in order
# to avoid a strange collision that happened when merging data frames.
# Need to double-check if this was due corruption in the draft code.

test.data      <- read.table("./UCI HAR Dataset/test/X_test.txt")
test.subj      <- read.table("./UCI HAR Dataset/test/subject_test.txt",
                             col.names = "subject")
test.complete  <- cbind(test.subj, test.data)

train.data     <- read.table("./UCI HAR Dataset/train/X_train.txt")
train.subj     <- read.table("./UCI HAR Dataset/train/subject_train.txt",
                             col.names = "subject")
train.complete <- cbind(train.subj, train.data)

# Partial Cleanning

rm(list = "train.data", "train.subj", "test.data", "test.subj")

merged.data    <- merge(test.complete, train.complete, all = TRUE)

# Partial Cleanning

rm(list = "test.complete","train.complete")

# Subset the merged data set into another that contains only
# mean and standard deviation data.

merged.avg.std <- merged.data[, c(1, avg.std.cols)]

# Assign features to column names.

colnames(merged.avg.std) <- headings.data[c(1, avg.std.cols)]

# Partial Cleanning

rm(list = "avg.std.cols", "headings.data")

# Creates the data frame with the average of each variable 
# for each activity and each subject

library(plyr)

avg.activity.subject <- ddply(merged.avg.std, .(subject), numcolwise(mean))

# Exports the tidy data frame to a tab delimited file

write.table(avg.activity.subject, "./tidy.txt", sep="\t")
