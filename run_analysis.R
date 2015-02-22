#Reading Data

  #Reading Test Data
  X_test <- read.table("UCI HAR Dataset\\test\\X_test.txt",stringsAsFactors = FALSE)
  y_test <- read.table("UCI HAR Dataset\\test\\y_test.txt",stringsAsFactors = FALSE)
  subject_test <- read.table("UCI HAR Dataset\\test\\subject_test.txt",,stringsAsFactors = FALSE)
  
  #Reading Trianing Data
  X_train <- read.table("UCI HAR Dataset\\train\\X_train.txt",stringsAsFactors = FALSE)
  y_train <- read.table("UCI HAR Dataset\\train\\y_train.txt",stringsAsFactors = FALSE)
  subject_train <- read.table("UCI HAR Dataset\\train\\subject_train.txt",,stringsAsFactors = FALSE)
  
  #Reading features and activity_labels
  activity_labels <- read.table("UCI HAR Dataset\\activity_labels.txt",stringsAsFactors = FALSE)
  features <- read.table("UCI HAR Dataset\\features.txt",stringsAsFactors = FALSE)
  
  #Merging Data
  
    #Merging test and train data on measurements....1
    xmerge <- rbind(X_test,X_train)
    #Merging test and train data on activity......2
    ymerge <- rbind(y_test,y_train)
    #Meging 1 and 2
    xymerge <- cbind(xmerge,ymerge)#.......3
    #Merging Subject Data
    xymerge[,(ncol(xymerge)+1)] <- rbind(subject_test,subject_train)
  
  #Step 2 - Keep only mean and std data. Resulting dataset is xymerge2
  x <- lapply(1:nrow(features),function(x) grepl("mean()", features[x,2],fixed=TRUE))
  y <- lapply(1:nrow(features),function(x) grepl("std()", features[x,2],fixed=TRUE))
  xymerge2 <- xymerge[,unlist(x)|unlist(y)]
  
  
  #Step 3 - 3.Uses descriptive activity names to name the activities in the data set
  xymerge2[,(ncol(xymerge2)-1)] <- unlist(lapply(1:nrow(xymerge2), function(x) activity_labels[activity_labels[,1]==xymerge2[x,(ncol(xymerge2)-1)],2]))
  
  #Step 4 - 4.Appropriately labels the data set with descriptive variable names. 
  colnames(xymerge2)[1:length(features[unlist(x)|unlist(y),2])] <- features[(features[unlist(x)|unlist(y),1]),2]
  colnames(xymerge2)[67] <- "Activity"
  colnames(xymerge2)[68] <- "Subject"
  
  #Step5 - 5.From the data set in step 4, creates a second, independent tidy data set 
  # I first use melt to create long dataset and then use dcast to create wide dataset
  # and calculate averages
  library(reshape2)
  tidyMelt <- melt(xymerge2,id.vars=c("Subject","Activity"))
  tidyDataset <- dcast(tidyMelt,Subject+Activity ~ variable,mean)
  tidyDataset <- tidyDataset[order(tidyDataset$Subject,tidyDataset$Activity),]
  
  Enter file contents here
