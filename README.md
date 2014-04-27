GetCleanData
============

Repository created solely for the program assignments of the course "Getting and Cleaning Data".

The file **run_analysis.R** contains the script required for solving the exercises of the "Peer Assessment".

For testing purposes remember to set your working directory.

The script is intended to produce a tidy dataset of the means of the 66 variables that met the assignment requirements, that is, the variables that represent the mean and standard deviation of several measurements, per subjects and activities.

For doing that, it loads 8 different files into R
  * **features.txt** (contains the column names)
  * **X_test.txt** (contains the "test" dataset)
  * **y_test.txt** (contains the activities indexes of the "test" dataset)
  * **subject_test.txt** (contains subject indexes of the "test" dataset)
  * **X_train.txt** (contains the "train" dataset)
  * **y_train.txt** (contains the activities indexes of the "train" dataset)
  * **subject_train.txt** (contains the subject indexes of the "train" dataset)
  * **activity_labels.txt** (codebook for activities)

Since features didn't accomplish R conventions for column names, the first step was to fix them and get them ready to be used in further steps. Also, column indexes for selected features were collected into a variable. Regular expressions were the main tool used for that purpose with the sole exception of the function **tolower** for transforming the strings into lower case.

The next step was putting together subjects, activities, and data into a single dataset in order to facilitate further processing and analyses. After that the 2 resultant datasets (**test.complete** and **train.complete**) were merged as required.

For subsetting the merged data frame the previously collected column indexes were used.

Next, the average for each variable was calculated per subject and activity by using the **ddply** function from the  **plyr** package.

Finally, the activity codes where changed to their actual meaningful values and the tidy dataset was completed.

Three different datasets are returned by the script, for evaluation purposes:
  * **"merged.data"** The merged test and train datasets
  * **"merged.avg.std"** A subset of the "merged.data" with only the subject, mean and standard deviation columns 
  * **"tidy.data"** The tidy dataset with the mean of each variable per subject
