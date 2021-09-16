---
title: "Code Book"
---
## Description of the data modification

The original data was stored in the project folder. 
The R script stored in run_analysis.R modifies the original data in the following 5 steps:

1. The training and the test sets are merged to create one data set.

2. Only the measurements on the mean and standard deviation for each measurement are extracted.
According to the description in features_info.txt only features, whoes names ended in -mean() or -std() were selected. So, only 66 measurements from the original list remained.

3. Descriptive activity names are used to name the activities in the data set
Activities were used as factors. Labels were taken from the activity_labels.txt

4. The data set is appropriately labeled with descriptive variable names. 
Complete words were used instead of their abbreviations.

5. From the data set in step 4, is created a second, independent tidy data set with the average of each variable for each activity and each subject.

---

## Description of the data fields in tidy.txt

### Identifiers
* Subjects - ID of the test subject (one of the 30 volunteers performing activities)
* Activities - The type of physical activity performed by the subject.

### Activity Names
1. WALKING: the subject was walking during the test
2. WALKING_UPSTAIRS: the subject was walking up stairs during the test
3. WALKING_DOWNSTAIRS: the subject was walking down stairs during the test
4. SITTING: the subject was sitting during the test
5. STANDING: the subject was standing during the test
6. LAYING: the subject was laying down during the test

### Features
These are actual measurements, performed during the activities
On Step 2 only the measurements on the mean and standard deviation for each measurement were extracted.