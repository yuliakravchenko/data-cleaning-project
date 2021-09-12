# My script

#Step 0 - Reading the training and test datasets
traindata <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)
trainlabels <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE)

testdata <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)
testlabels <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE)

#Step 1 - Merges the training and the test sets to create one data set.
data <- rbind(traindata, testdata)
labels <- rbind(trainlabels, testlabels)

#Step 2 - Extracts only the measurements on the mean and standard deviation for each measurement.
#Figure out measurement names.
features <- read.table("./UCI HAR Dataset/features.txt", header = FALSE)
data2 <- data[, grep("-mean|-std", features$V2)]