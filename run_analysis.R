##Peer Graded Assignment Coursera Course 'Getting and Cleaning Data'

run_analysis <- function(){
        
        ##Download the zip file with the data for the assignment.
        ##Unzip the file. No additional tests are made to check whether the file is already unzipped.
        if (!file.exists("./AssignmentData.zip")) {
                url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
                download.file(url, destfile = "AssignmentData.zip", method = "curl")
                unzip("AssignmentData.zip")
        }
        
        ##Read the activities file. These are the activities performed during the training and test sessions.
        act_lbl <- read.table(file.path(getwd(),"UCI HAR Dataset", "activity_labels.txt"))
        names(act_lbl) <- c("activity_number", "activity_description")
        
        ##Read the features measured in the experiment
        features <- read.table(file.path(getwd(),"UCI HAR Dataset", "features.txt"))
        names(features) <- c("feature_number", "feature_description")
        
        ##Read test data
        act_test <- read.table(file.path(getwd(),"UCI HAR Dataset", "test", "y_test.txt"))
        subjects_test <- read.table(file.path(getwd(),"UCI HAR Dataset", "test", "subject_test.txt"))
        test_data <- read.table(file.path(getwd(),"UCI HAR Dataset", "test", "X_test.txt"))
        
        ##Give the columns in the test data frames a descriptive name to avoid errors when merging.
        ##No unique identifyers per row are available so the 'rownames' are used and added to each data frame
        ##as the 'id' column. 
        ##The result of these actions are data frames with the following columns:
        ##   - act_test      : 2 columns, activity_number and id
        ##   - subjects_test : 2 columns, subject_number and id
        ##   - test_data     : id, 561 columns, 1 column/measured feature (column names are available in 
        ##                        'features' data frame. It is assumed that the first feature corresponds to
        ##                        the measurement of the first column, etc.)
        act_test$id <- rownames(act_test)
        names(act_test) <- c("activity_number", "id")
        subjects_test$id <- rownames(subjects_test)
        names(subjects_test) <- c("subject_number", "id")
        names(test_data) <- features[,"feature_description"]
        test_data$id <- rownames(test_data)
        
        ##Merge the data frames containg the test subjects and activities. 
        merged_test_subjects_act <- merge(subjects_test, act_test, by.x = "id", by.y = "id", all = TRUE)
        
        ##Merge the merged subjects and activities with the test data, leave out the row names. 
        merged_test_subjects_act_test_data <- merge(merged_test_subjects_act, test_data, by.x = "id", by.y = "id", by = 0, all = TRUE)
        merged_test_subjects_act_test_data <- select(merged_test_subjects_act_test_data,-1)
        
        ##Read Training data
        act_training <- read.table(file.path(getwd(),"UCI HAR Dataset", "train", "y_train.txt"))
        subjects_training <- read.table(file.path(getwd(),"UCI HAR Dataset", "train", "subject_train.txt"))
        training_data <- read.table(file.path(getwd(),"UCI HAR Dataset", "train", "X_train.txt"))
        
        ##Give the columns in the training data frames a descriptive name to avoid errors when merging.
        ##No unique identifyers per row are available so the 'rownames' are used and added to each data frame
        ##as the 'id' column. 
        ##The result of these actions are data frames with the following columns:
        ##   - act_training      : 2 columns, activity_number and id
        ##   - subjects_training : 2 columns, subject_number and id
        ##   - training_data     : id, 561 columns, 1 column/measured feature (column names are available in 
        ##                                  'features' data frame. It is assumed that the first feature corresponds to
        ##                        the measurement of the first column, etc.)
        act_training$id <- rownames(act_training)
        names(act_training) <- c("activity_number", "id")
        subjects_training$id <- rownames(subjects_training)
        names(subjects_training) <- c("subject_number", "id")
        names(training_data) <- features[,"feature_description"]
        training_data$id <- rownames(training_data)

        ##Merge the data frames containg the training subjects and activities. 
        merged_training_subjects_act <- merge(subjects_training, act_training, by.x = "id", by.y = "id", all = TRUE)
        
        ##Merge the merged subjects and activities with the training data, leave out the row names. 
        merged_training_subjects_act_training_data <- merge(merged_training_subjects_act, training_data, by.x = "id", by.y = "id", all = TRUE)
        merged_training_subjects_act_training_data <- select(merged_training_subjects_act_training_data, -1)

        ##Merge test (merged_test_subjects_act_test_data) and training (merged_training_subjects_act_training_data)
        ##data frames into all_data.
        ##all_data contains:
        ##      - subject_number
        ##      - activity_description
        ##      - 1 column/measured feature (561 in total)
        all_data <- rbind(merged_test_subjects_act_test_data, merged_training_subjects_act_training_data)
       
        ##Select the columns with names containing 'mean()' and 'std()' because these columns contain 
        ##measurements on which the mean and std are calculated as such.  
        ##Grep is used to retrieve a vector of indices indicating the columns containing "mean()" and "std()".
        ##This vector is based on the features data frame.
        ##These indices are used to filter the all_data data frame on the columns.
        ##2 is added to each column indice because the all_data frame starts with the columns 
        ##containing the subject number and activitiy description.
        mean_features <- grep("mean()", features$feature_description, fixed = TRUE)
        std_features <- grep("std()", features$feature_description, fixed = TRUE)
        columns_to_keep <- c(mean_features,std_features)
        columns_to_keep <- sort(columns_to_keep) + 2  
        
        ##Select the first and second column, and all the columns with mean() and std() in the column name.
        all_data_to_keep <- select(all_data, 1, 2, columns_to_keep)
        
        ##Use the descriptive names for the activities in the data frame.
        ##Leave out the first column in the merged data frame because it contains the activity number.
        dat_ungrouped <- merge(act_lbl, all_data_to_keep, by = "activity_number", all.y = TRUE)
        dat_ungrouped <- select(dat_ungrouped, -1)
        
        ##Melt the data frame so that all columns become measures except the activity description and subject number.
        ##The variable name is set through the argument 'variable_name' in the melt method.
        datMelt <- melt(dat_ungrouped, id = c("activity_description", "subject_number"), variable_name = "feature")
       
        ##Group the data by subject_number, activity_description and feature to calculate the mean according to these grouped variables.
        dat_grouped <- datMelt %>% group_by(subject_number, activity_description, feature)
        result <- summarize(dat_grouped, mean = mean(value, na.rm = TRUE))
        
        ##Write the result in a text file called 'tidyDataSetTineM.txt'.
        write.table(result, file = file.path(getwd(), "tidyDataSetTineM.txt"), row.names = FALSE)
        
}