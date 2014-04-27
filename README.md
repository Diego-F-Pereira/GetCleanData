GetCleanData
============

Repository created solely for the program assignments of the course "Getting and Cleaning Data".

The file PA2r.R contains the script required for solving the exercises of the "Peer Assessment".

The script is intended to produce a tidy dataset from the mean of the 66 variables that met the assignment requirements, that is, the variables that represent the mean and standard deviation of several measurements.

For doing that, it loads 5 different files into R
  * **features.txt** (contains the column names)
  * **X_test.txt** (contains the test dataset)
  * **subject_test.txt** (contains subject indexes of the test dataset)
  * **X_train.txt** (contains the training dataset)
  * **subject_train.txt** (contains the subject indexes of the training dataset)

Since features didn't accomplish R conventions for column names, the first step was to fix them and get them ready to be used in further steps. Also, column indexes for selected features were collected into a variable. Regular expressions were the main tool used for that purpose with the sole exception of the function **tolower** for transforming the strings into lower case.

The next step was putting together subjects and data into a single dataset in order to facilitate further processing and analyses. After that the 2 datasets were merged as required.

For subsetting the resultant data frame the previously collected column indexes were used.

Finally, the average for each variable was calculated per subject by using the **ddply** function from the package **plyr**.
