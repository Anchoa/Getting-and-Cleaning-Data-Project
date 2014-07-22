Getting-and-Cleaning-Data-Project
=================================

step 0: Load and extract files (optional)
* You can uncomment this for download and extract files in the working directory
* Additionaly remove 'method="curl"' if not needed (Windows)

step 1: Merges the training and the test sets to create one data set.
* Train and test tables are loaded with 'read.table'. Dimensions (7352x561) and (2947x561). They are joined with 'rbind' since they have the same number of columns. We end up with a (10299x561) table
* Then load the file 'features.txt' where column names are. It has 561 elements, with names of variables in second column. It is applied to dataset with the function 'names'.

step 2: Extracts only the measurements on the mean and standard deviation for each measurement.
* I use the 'subset' function. To select columns, 'grep' is used with names containing 'mean()' or 'std()'. The result is a data frame with dimension (10299x66).

step 3: Uses descriptive activity names to name the activities in the data set
* Files 'y_train.txt' and 'y_test.txt' are loaded. The dimensions are (7352x1) and (2947x1); the same rows as the data frames obtained in step 1. They are joined likewise with 'rbind'.
* Later it is transformed to a factor and the name of the activities (lowercase) in file 'activity_labels.txt' are applied to factor levels.
* This factor can be added to the data set as a column (same number of rows), but I wait until step 5 when function 'aggregate' will use that factor.

step 4: Appropriately labels the data set with descriptive variable names. 
* Removes '(' and ')' characters. Changes '-' character by '.' character. Parentheses and dashes have special meaning in R.
* There seems to be an error in the repetition 'BodyBody' in some variables. 'BodyBody' is changed to 'Body'.
* The domains 't' and 'f' are clearer if the entire word is displayed.

step 5: Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
* First of all, another factor is needed for subjects (the activity factor has already been built). The same method as in activities. In this case no need to name the levels. They will be from 1 to 30.
* Now we have a table size 10299x66 and two factors sized 10299, one with 6 levels and the other with 30. The 'aggregate' function is used to group in 180 rows (30 subjects and 6 activities). Function 'mean' is used to obtain the mean of each variable in each group subject/activity. Result is dimension 180X68 (66 variables plus 2 factors).
* Finally, the name is changed to the first two columns (factors) and the data frame is written to a file.
