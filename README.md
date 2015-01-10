# Contents
1. run_analysis.R
2. tidyDataSet.txt
2. create_codebook.R
3. codeBook.md
4. README.md

## run_analysis.R
This R file contains functions to analyze the data, zipped or not, in the working directory. The code will take the standard deviation and mean features from the accelerometer data, and take their mean over each subject and activity. There are three functions:

#### getTidyData()

getTidyData() returns a tidy data set of means of the mean() and std() measurements from the "test" and "train" accelerometer data (through getMeanStdData()), taken over each subject/activity combination. This is the driving function of the R file, called with no parameters.

#### getMeanStdData()

getMeanStdData() compiles the mean() and std() features from the accelerometer data into a data frame if the data folder or zipped data file are in the current working directory. All mean() and std() measurements, along with the subject and activity, are returned from "test" and "train" (each through compileDataSet()) as one data frame. Called from getTidyData().

#### compileDataSet()

compileDataSet() compiles the relevant data set for a given category ("test" or "train"). Feature names are pulled from features.txt, and the actual feature data from the correct subfolder's X_(category).txt file. This is then refined to only include std() or mean() measurements. Activity data is then pulled from the correct subfolder's y_(category).txt file, with the character descriptions of each activity pulled from activity_labels.txt. Subjects are then pulled from the correct subfolder's subject_(category).txt file. All are concatentated into a data frame with appropriate names and returned. Called from getMeanStdData().

## tidyDataSet.txt

Tidy data set returned from getTidyData(), above

## create_codebook.R

Create codebook (codeBook.md) for tidy data set from features.txt.

## codeBook.md

Codebook markdown for tidy data set

## README.md

This readme markdown