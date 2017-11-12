


> Written with [StackEdit](https://stackedit.io/).

***Code Book Peer Graded Assignment Getting and Cleaning Data***

**Content**
-----------
 1. Study Design
 2. Code Book

**1. Study Design**
-------------------
The aim of this analysis is to clean a data set that can be found on UCI Machine Learning Repository (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). This data set contains data from accelerometers from a smartphone from Samsung (Galaxy S). The mean of measured features on mean and std has to be calculated per activity, subject and measured feature.  

There are two sets of data files in the downloaded raw data on which this analysis is based:
		 1. test data
		 2. training data
Each set contains 3 files and an 'Inertial Signal' folder.  Only the former are used in the analysis:
		 1. a subject file: subject_test.txt / subject_train.txt
		 2. a test data file: X_test.txt / X_train.txt
		 3. an activity file: y_test.txt / y_train.txt 

More information on the raw data can be found in the README.txt and features_info.txt files that are downloaded together with the data files.

**2. Code Book**
----------------
The tidy data set "tidyDataSetTineM.txt" contains 4 columns.

1. subject_number - Integer

- 1 .. 30

 2. activity_description - Factor with 6 levels

 - WALKING
 - WALKING_UPSTAIRS
 - WALKING_DOWNSTAIRS
 - SITTING
 - STANDING
 - LAYING	
			
 3. feature - Factor with 66 levels

 - tBodyAcc-mean()-X
 - tBodyAcc-mean()-Y
 - tBodyAcc-mean()-Z
 - tGravityAcc-mean()-X
 - tGravityAcc-mean()-Y
 - tGravityAcc-mean()-Z
 - tBodyAccJerk-mean()-X
 - tBodyAccJerk-mean()-Y
 - tBodyAccJerk-mean()-Z
 - tBodyGyro-mean()-X
 - tBodyGyro-mean()-Y
 - tBodyGyro-mean()-Z
 - tBodyGyroJerk-mean()-X
 - tBodyGyroJerk-mean()-Y
 - tBodyGyroJerk-mean()-Z
 - tBodyAccMag-mean()
 - tGravityAccMag-mean()
 -  tBodyAccJerkMag-mean()
 - tBodyGyroMag-mean()
 - tBodyGyroJerkMag-mean()
 - fBodyAcc-mean()-X
 - fBodyAcc-mean()-Y
 - fBodyAcc-mean()-Z
 - fBodyAccJerk-mean()-X
 - fBodyAccJerk-mean()-Y
 - fBodyAccJerk-mean()-Z
 - fBodyGyro-mean()-X
 - fBodyGyro-mean()-Y
 - fBodyGyro-mean()-Z
 - fBodyAccMag-mean()
 - fBodyBodyAccJerkMag-mean()
 - fBodyBodyGyroMag-mean()
 - fBodyBodyGyroJerkMag-mean()
 - tBodyAcc-std()-X
 - tBodyAcc-std()-Y
 - tBodyAcc-std()-Z
 - tGravityAcc-std()-X
 - tGravityAcc-std()-Y
 - tGravityAcc-std()-Z
 - tBodyAccJerk-std()-X
 - tBodyAccJerk-std()-Y
 - tBodyAccJerk-std()-Z
 - tBodyGyro-std()-X
 - tBodyGyro-std()-Y
 - tBodyGyro-std()-Z
 - tBodyGyroJerk-std()-X
 - tBodyGyroJerk-std()-Y
 - tBodyGyroJerk-std()-Z
 - tBodyAccMag-std()
 - tGravityAccMag-std()
 - tBodyAccJerkMag-std()
 - tBodyGyroMag-std()
 - tBodyGyroJerkMag-std()
 - fBodyAcc-std()-X
 - fBodyAcc-std()-Y
 - fBodyAcc-std()-Z
 - fBodyAccJerk-std()-X
 - fBodyAccJerk-std()-Y
 - fBodyAccJerk-std()-Z
 - fBodyGyro-std()-X
 - fBodyGyro-std()-Y
 - fBodyGyro-std()-Z
 - fBodyAccMag-std()
 - fBodyBodyAccJerkMag-std()
 - fBodyBodyGyroMag-std()
 - fBodyBodyGyroJerkMag-std()

4. mean - number

