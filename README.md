# Course3Project

**************************************************************************
Data to be read
**************************************************************************
The script "run_analysis.R" assumes that folder "UCI HAR Dataset" is present in the working directory

First part of the code uses read.table to read the following:
1)Test Data:
files: X_test.txt, y_test.txt, subject_test.txt
2) Train Data
files: X_train.txt, y_train.txt, subject_train.txt
3)features and activity_labels dta:
files: activity_labels.txt,features.txt

I have used variable names same as the file names for code readability.

***********************************************************************
Required library for the code - reshape2
***********************************************************************


Steps
*************************************************************************
Step 1( of 5):
I use cbind and rbind functions to merge the test and train data.   The resultant dataframe is names xymerge. This dataframe has 563 columns - 561 measuring variables and 2 coumns for subject and activity. xymerge is used in subsequent steps for subsetting.

Step 2( of 5)
I use grepl function to find matching rows containing "mean()" and "std()" in the features table. The xymerge2 is created in this step which has 68 columns containing means,stds and activity and subject data.

Step 3: xymerge2 is modiffied so that the activity column contains activity names as character
Step 4: column names are changed from default to descriptive column names
Step5: I use function melt (from library reshape2) to create a long dataset. Finally I use function dcast to create a wide data set which gives average values for the measuring variables. There is one row for each combination of subject and activity. Subject numbers are 1 to 30 and activity names are same as features file.



