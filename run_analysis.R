
## getTidyData() retrieves a tidy data set of means of the mean() and std()
## measurements from the "test" and "train" accelerometer data, taken over
## each subject/activity combination
getTidyData <- function(){
    ## Get data frame of subject, activity, and mean and standard deviation
    ## features from the "test" and "train" accelerometer data.
    dataSet <- getMeanStdData()
    
    ## Given the data frame returned from getMeanStdData(), return averages of
    ## measurements over each subject and activity
    print("Tidying data...")
    dataSetTidy <- aggregate(dataSet[, 3:dim(dataSet)[2]], by = dataSet[, 1:2], mean)
    
    ## Rename fields to reflect values
    names(dataSetTidy)[3:length(dataSetTidy)] <- paste(names(dataSetTidy)[3:length(dataSetTidy)], ".mean", sep = "")
    
    ## Return tidy data set
    return(dataSetTidy)
}

## getMeanStdData() compiles the mean() and std() features from the accelerometer
## data into a data frame if the data folder or zipped data file are in the
## current working directory. All mean() and std() measurements, along with
## the subject and activity, are returned from "test" and "train" as one data
## frame.
getMeanStdData <- function(){
    ## Store path to folder
    dataPath <- "UCI HAR Dataset/"
    
    ## If the data directory does not exist, check for zipped file and unzip it
    if(!file.exists(dataPath)){
        ## Data not found
        print(paste("Data not found in ", getwd(), "/", dataPath, ".", sep = ""))
        
        ## Store name of zipped data file (which should exist in working directory)
        zippedDataFileName <- "getdata-projectfiles-UCI HAR Dataset.zip"
        
        if(file.exists(zippedDataFileName)){
            ## Zipped data found
            print(paste("Zip file ", zippedDataFileName, " found.", sep = ""))
            
            ## Unzip data
            print("Unzipping data...")
            unzip(zippedDataFileName)
        } else {
            ## Zipped data not found. Exit program.
            stop(paste("Zip file ", zippedDataFileName, " not found.", sep = ""))
        }
    } else {
        print("Data folder found.")
    }
    
    ## Create test data set
    print("Loading test data...")
    testData <- compileDataSet(dataPath, "test")
    
    ## Create train data set
    print("Loading train data...")
    trainData <- compileDataSet(dataPath, "train")
    
    ## Union the data frames together to get one data set
    dataSet <- rbind(testData, trainData)
    
    print("Data sets combined.")
    
    ## Return data set
    return(dataSet)
}

## compileDataSet() compiles the relevant data set for a given category (test or
## train). Feature names are pulled from features.txt, and the actual feature
## data from the correct subfolder's X_(folder_name).txt file. This is then
## refined to only include std() or mean() measurements. Activity data is then
## pulled from the correct subfolder's y_(folder_name).txt file, with the
## character descriptions of each activity pulled from activity_labels.txt.
## Subjects are then pulled from the correct subfolder's subject_(folder_name).txt
## file. All are concatentated into a data frame with appropriate names and
## returned.
compileDataSet <- function(dataPath, dataCat){
    
    ## Load feature names into character vector
    featureNames <- read.table(paste(dataPath, "features.txt", sep = ""), stringsAsFactors = FALSE)[, 2]
    
    ## Load feature data into data frame
    featureDataTemp <- read.table(paste(dataPath, dataCat, "/X_", dataCat, ".txt", sep = ""))
    
    ## Assign names to data frame
    names(featureDataTemp) <- featureNames
    
    ## Only pick up features with std() or mean() as per assignment specs
    whichFeatures <- grep("std\\(\\)|mean\\(\\)", featureNames)
    
    ## Refine fields
    featureData <- featureDataTemp[whichFeatures]
    
    ## Load activity names to merge later (not here, as it will sort rows)
    activityLabels <- read.table(paste(dataPath,"activity_labels.txt", sep = ""))
    
    ## Load activity data
    activityData <- read.table(paste(dataPath, dataCat, "/y_", dataCat, ".txt", sep = ""))
    
    ## Rename activity fields
    names(activityLabels) <- c("activityKey", "activity")
    names(activityData) <- "activityKey"
    
    ## Load subjects
    subjectData <- read.table(paste(dataPath, dataCat, "/subject_", dataCat, ".txt", sep = ""))
    
    ## Rename subject field
    names(subjectData) <- "subject"
    
    ## Concatenate subject, activity, and features into a data frame
    dataSetConcat <- data.frame(subjectData, activityData, featureData)
    
    ## Merge activity labels to dataSet to get descriptive names
    dataSetMerged <- merge(activityLabels, dataSetConcat, by = "activityKey")
    
    ## Drop numeric activity column
    dropColumn <- "activityKey"
    dataSetUnordered <- dataSetMerged[, !(names(dataSetMerged) %in% dropColumn)]
    
    ## Reorder columns
    dataSet <- dataSetUnordered[, c("subject", "activity", names(dataSetUnordered[, 3:dim(dataSetUnordered)[2]]))]
    
    ## Return the data frame
    return(dataSet)
}