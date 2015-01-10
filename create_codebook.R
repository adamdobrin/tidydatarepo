## Create codebook markdown and txt for tidy data set from features.txt
createCodebook <- function(){
    ## Load feature names
    filePath <- "UCI HAR Dataset/features.txt"
    featuresNamesRaw <- read.table(filePath)
    
    ## Only pick up feature names with std() or mean() as per assignment specs
    whichFeatures <- grep("std\\(\\)|mean\\(\\)", featuresNamesRaw[, 2])
    
    ## Refine fields to match columns
    featuresNames <- paste(sub("\\(\\)", "..", gsub("-", ".", featuresNamesRaw[whichFeatures, 2])), ".mean", sep = "")
    
    ## Prepend subject/activity rows
    codebookNames <- c("subject", "activity", featuresNames)
    
    ## Attach index
    codebookTemp <- paste(row(matrix(codebookNames)), codebookNames, "  ", sep = " ")
    
    ## Prepend header and data set description to complete codebook
    codebook <- c("# Codebook",
                  "This codebook describes the dataset returned from run_analysis.R.  ",
                  "",
                  paste("That code takes the standard deviation and mean features from the original accelerometer data, and finds the mean over each subject and activity (as fields 3-", as.character(length(codebookTemp)), "), grouped over subject and activity.  ", sep = ""),
                  "",
                  "For description of original data, see README.txt and features_info.txt in original data directory.",
                  "## Fields",
                  codebookTemp)
    
    ## Write codebook to file (md and txt)
    write.table(codebook, "codebook.md", quote = FALSE, row.name = FALSE, col.name = FALSE)
    write.table(codebook, "codebook.txt", quote = FALSE, row.name = FALSE, col.name = FALSE)
    
    ## Return codebook
    return(codebook)
}