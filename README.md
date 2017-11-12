


> Written with [StackEdit](https://stackedit.io/).

The script is written with RStudio - the R version used is 3.4.2.

Content
-------
 1. Before running the script
 2. Script
 3. Viewing the tidy data set


**1. Before running the script**
-----------------------------
The basic data packages in R are used. I had to install the following packages:
		 - reshape (reshape2 cannot be used with R version 3.4.2)
		 - dplyr

**2. Script**
----------
The script is called run_analysis.

In the script the zip file with the data for the assignment is downloaded (in case this is not done yet) and unzipped. This is done in the working directory.
No additional tests are made to check whether the file is already unzipped.
No messages are displayed while downloading the data from the internet and unzipping. This can take some time, it depends from the internet speed.

Then the data files are read into data frames using the folder structure of the unzipped file:

 1. Activities file read from file activity_labels.txt: this is a list of the activities performed during the training and test sessions.
 2. Features file read from file features.txt: these are the features measured during the training and test sessions.
 3. Test Data Manipulation (see below)
 4. Training Data Manipulation (see below)

To avoid errors when merging data frames, column names are given as soon as the data frames are created. No unique identifyers per row were available in the raw data so the 'rownames' are used as 'id' columns. 

*Test Data Manipulation*
The following data frames are created:

 - act_test read from file y_test.txt: 2 columns, activity_number and id
 - subjects_test read from file subject_test.txt: 2 columns, subject_number and id
 - test_data read from file X_test.txt: id + 561 columns, 1 column/measured feature (column names are available in features' data frame. It is assumed that the first feature corresponds to the measurement of the first column, etc.)
  
The following data frames are merged:       

 - test subjects and corresponding activities
 - the merged subjects and activities with the test data
       
*Training Data Manipulation*
The following data frames are created:

 - act_training read from file y_train.txt: 2 columns, activity_number and id
 - subjects_training read from file subjects_train.txt: 2 columns, subject_number and id
 - training_data read from file X_train.txt: id + 561 columns, 1 column/measured feature (column names are available in features' data frame. It is assumed that the first feature corresponds to the measurement of the first column, etc.)

The following data frames are merged:    
   
 - training subjects and corresponding activities
 - the merged subjects and activities with the training data

Then the test and training data frames created above are 'rbinded' into a data frame with the following columns:

 - subject_number
 - activity_description
 - 1 column/measured feature (561 in total)

Then only the columns with names containing 'mean()' and 'std()' are selected because these columns contain measurements on which the mean and std are calculated as such.  

In the next step the descriptive names for the activities are uploaded in the data frame.

Then the data frame is melted so that all columns become measures except the activity_description and subject_number. Descriptive variable names are used. Then this data frame is grouped by subject_number, activity_description and feature to calculate the mean according to these grouped variables.

Lastly, the result is written in a text file called 'tidyDataSetTineM.txt'.

**3. Viewing the tidy data set**
----------
The result of the assignment is a tidy data set saved to a file called "tidyDataSetTineM.txt". Use the following commands for reading the tidy data set:

    data <- read.table(file.path(getwd(), "tidyDataSetTineM.txt"), header = TRUE)
    View(data)





 