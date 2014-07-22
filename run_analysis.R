# 0. Load and extract files
# uncomment for download and extract files in working directory
# remove 'method="curl"' if not needed

#url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#file <- "getdata-projectfiles-UCI HAR Dataset.zip"
#download.file(url,destfile=file) ,method="curl")
#unzip(file)
#rm(url,file)

# 1. Merges the training and the test sets to create one data set.

trainSet <- read.table("UCI HAR Dataset/train/X_train.txt")
testSet <- read.table("UCI HAR Dataset/test/X_test.txt")

dataSet <- rbind(trainSet,testSet)

rm(trainSet,testSet)

colLabels <- read.table("UCI HAR Dataset/features.txt")

names(dataSet) <- colLabels[,2]

rm(colLabels)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

meanstdSet <- subset(dataSet, TRUE, select=grep("mean\\(\\)|std\\(\\)",names(dataSet),value=TRUE))

rm(dataSet)

# 3. Uses descriptive activity names to name the activities in the data set

activityTrain <- read.table("UCI HAR Dataset/train/y_train.txt")
activityTest <- read.table("UCI HAR Dataset/test/y_test.txt")

activityAll <- rbind(activityTrain,activityTest)

rm(activityTrain,activityTest)

factorActivities <- factor(activityAll[,1])
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
levels(factorActivities) <- tolower(activityLabels[,2])

rm(activityLabels,activityAll)

# 4. Appropriately labels the data set with descriptive variable names. 

names(meanstdSet) <- gsub("\\(","",names(meanstdSet))
names(meanstdSet) <- gsub("\\)","",names(meanstdSet))
names(meanstdSet) <- gsub("-",".",names(meanstdSet))
names(meanstdSet) <- gsub("BodyBody","Body",names(meanstdSet))
names(meanstdSet) <- gsub("^t","time",names(meanstdSet))
names(meanstdSet) <- gsub("^f","frequency",names(meanstdSet))

# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

# subjects

subjectsTrain <- read.table("UCI HAR Dataset/train/subject_train.txt")
subjectsTest <- read.table("UCI HAR Dataset/test/subject_test.txt")

subjectsAll <- rbind(subjectsTrain,subjectsTest)

rm(subjectsTrain,subjectsTest)

factorSubjects <- factor(subjectsAll[,1])

rm(subjectsAll)

tidyDataSet <- aggregate(meanstdSet,by=list(factorSubjects,factorActivities),FUN=mean)
names(tidyDataSet)[1:2] <- c("Subject","Activity")

rm(meanstdSet,factorSubjects,factorActivities)

write.table(tidyDataSet,"tidyDataSet.txt",row.names=FALSE)

# to load data use:
# data <- read.table("tidyDataSet.txt",header=TRUE)
