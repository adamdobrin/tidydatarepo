# Contents
1. run_analysis.R
2. tidyDataSet.txt
2. create_codebook.R
3. codebook.md
4. codebook.txt
4. README.md
5. getdata-projectfiles-UCI HAR Dataset.zip

## run_analysis.R
Contains functions to analyze the data, zipped or not, in the working directory. The code will take the standard deviation and mean features from the accelerometer data, and take their mean over each subject and activity. There are three functions:

#### getTidyData()

getTidyData() returns a tidy data set of means of the mean() and std() measurements from the "test" and "train" accelerometer data (through getMeanStdData()), taken over each subject/activity combination. This is the driving function of the R file, called with no parameters.

#### getMeanStdData()

getMeanStdData() compiles the mean() and std() features from the accelerometer data into a data frame if the data folder or zipped data file are in the current working directory. All mean() and std() measurements, along with the subject and activity, are returned from "test" and "train" (each through compileDataSet()) as one data frame. Called from getTidyData().

#### compileDataSet()

compileDataSet() compiles the relevant data set for a given category ("test" or "train"). Feature names are pulled from features.txt, and the actual feature data from the correct subfolder's X_(category).txt file. This is then refined to only include std() or mean() measurements. Activity data is then pulled from the correct subfolder's y_(category).txt file, with the character descriptions of each activity pulled from activity_labels.txt. Subjects are then pulled from the correct subfolder's subject_(category).txt file. All are concatentated into a data frame with appropriate names and returned. Called from getMeanStdData().

## tidyDataSet.txt

Tidy data set returned from getTidyData(), above

## create_codebook.R

Contains a single function (createCodebook()) to create codebook (codebook.md and codebook.txt) for tidy data set from features.txt.

## codebook.md

Codebook for tidy data set (markdown)

## codebook.txt

Codebook for tidy data set (txt)

## README.md

This readme markdown

## getdata-projectfiles-UCI HAR Dataset.zip

Zipped data; can also be found online [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) (as of 1/10/15)