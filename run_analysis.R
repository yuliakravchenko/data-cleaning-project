#Step 0 

#Reading features - measurements names
features <- read.table("./UCI HAR Dataset/features.txt", header = FALSE)
features[,2] <- as.character(features[,2])

#Reading activities
activities <- read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE)
activities[,2] <- as.character(activities[,2])

#Reading the training dataset
trainData <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)
trainLabels <- read.table("./UCI HAR Dataset/train/y_train.txt", col.name="Activity", header = FALSE)
trainSubjects <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.name="Subject", header = FALSE)

#Reading the test dataset
testData <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)
testLabels <- read.table("./UCI HAR Dataset/test/y_test.txt", col.name="Activity", header = FALSE)
testSubjects <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.name="Subject", header = FALSE)


#Step 1 - Merges the training and the test sets to create one data set.
train <- cbind(trainSubjects, trainLabels, trainData) # Binding subjects and activity labels with train data. 
test <- cbind(testSubjects, testLabels, testData) # Binding subjects and activity labels with test data. 
fullData <- rbind(train, test) # Binding train and test datasets


#Step 2 - Extracts only the measurements on the mean and standard deviation for each measurement.
requiredFeatures <- grep("-mean\\(|-std\\(", features$V2)
narrowData <- fullData[, c(1,2, requiredFeatures+2)] #Extract only the measurements, described as "mean" and "standard" deviation


#Step 3 - Uses descriptive activity names, stored in activities, to name the activities in the data set
narrowData$Activity = factor(narrowData$Activity, labels=activities[,2])


#Step 4 - Appropriately labels the data set with descriptive variable names. 
requiredFeaturesNames <- features[requiredFeatures,2]
requiredFeaturesNames <- gsub("[(][])]", "", requiredFeaturesNames) #Getting rid of "()"

#Making feature names more readable
requiredFeaturesNames <- gsub("^t", "Time Domain. ", requiredFeaturesNames)
requiredFeaturesNames <- gsub("^f", "Frequency Domain. ", requiredFeaturesNames)
requiredFeaturesNames <- gsub("-mean", "- Mean ", requiredFeaturesNames)
requiredFeaturesNames <- gsub("-std", "- Standard Deviation ", requiredFeaturesNames)
requiredFeaturesNames <- gsub("-X", "- in the X direction", requiredFeaturesNames)
requiredFeaturesNames <- gsub("-Y", "- in the Y direction", requiredFeaturesNames)
requiredFeaturesNames <- gsub("-Z", "- in the Z direction", requiredFeaturesNames)
requiredFeaturesNames <- gsub("BodyAcc", "Body Acceleration ", requiredFeaturesNames)
requiredFeaturesNames <- gsub("BodyGyro", "Body Gyroscope ", requiredFeaturesNames)
requiredFeaturesNames <- gsub("GravityAcc", "Gravity Acceleration signal ", requiredFeaturesNames)
requiredFeaturesNames <- gsub("Mag", " Magnitude ", requiredFeaturesNames)
requiredFeaturesNames <- gsub("BodyBody", "Body Body ", requiredFeaturesNames)

#Applying new feature names to the new data set.
names(narrowData) <- c("Subject", "Activity", requiredFeaturesNames)


#Step 5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidyData <- aggregate(narrowData[,3:68], by = list(Subject = narrowData$Subject, Activity = narrowData$Activity),FUN = mean)
write.table(tidyData, file = "tidy_data.txt", row.names = FALSE)
