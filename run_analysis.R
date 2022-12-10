setwd("C:\\Users\\eliza\\OneDrive\\Documents\\R\\datasciencecoursera\\UCI HAR Dataset")
library(stringr)
library(dplyr)

##LOAD RAW DATA
  #Load Training Data
trainsubject <- read.table("train/subject_train.txt", header = FALSE)
trainset <- read.table("train/X_train.txt", header = FALSE)
trainlabels <- read.table("train/Y_train.txt", header = FALSE)

  #Load Testing Data
testsubject <- read.table("test/subject_test.txt", header = FALSE)
testset <- read.table("test/X_test.txt", header = FALSE)
testlabels <- read.table("test/Y_test.txt", header = FALSE)

##EXTRACT THE MEAN AND STANDARD DEVIATION VALUES (requirement 2)
  #Use 'Features' txt for column names
datanames <- read.table("features.txt", header = FALSE)
names <- datanames[,2] #remove indexing column
  #Apply column names to data sets
colnames(testset) <- names
colnames(trainset) <- names
colnames(testsubject) <- "Subject"
colnames(trainsubject) <- "Subject"
colnames(testlabels) <- "Labels"
colnames(trainlabels) <- "Labels"
  #Use column names to pull out mean and standard deviation data columns
mean <- grep(pattern = "mean\\(\\)", x= names)
std <- grep(pattern = "std\\(\\)", x= names)
meanstd <- sort(append(mean, std))
  #select correct columns (only mean and std values) from test and training sets
testsetms <- testset[,meanstd]
trainsetms <- trainset[,meanstd]

##MERGE TEST AND TRAINING SET MEANS/STDS INTO ONE (Requirement 1)
  #Merge train data
trainMerge <- cbind(trainsubject, trainlabels, trainsetms)
  #Merge test data
testMerge <- cbind(testsubject, testlabels, testsetms)
  #Merge test and train, arrange by subject then by test label
totaldata <- arrange(rbind(trainMerge, testMerge), Subject, Labels)

#APPLY DESCRIPTIVE ACTIVITY NAMES (requirement 3)
totaldata$Labels <- recode(totaldata$Labels, "1" = "walking", 
                        "2" = "walking.upstairs",
                        "3" = "walking.downstairs",
                        "4" = "sitting",
                        "5" = "standing",
                        "6" = "laying")

#APPLY DESCRIPTIVE VARIABLE NAMES (requirement 4)
datanames <- colnames(totaldata)
  #define shorthand
replace<- c("mean\\(\\)","std\\(\\)", "tBody","fBody", "tGravity","Mag","Gyro","Acc","Jerk","Y","X","Z","-","BodyBody")
  #define descriptive replacements
replacements <- c("Mean", "Standard Dev", "Time: Body", "Frequency: Body", "Time: Gravity", " Magnitude", " Gyroscope", " Acceleration", " Jerk", "Y Axis", "X Axis", "Z Axis", " ", "Body")
  #replace
for(i in 1:length(replace)) {
  datanames <- str_replace_all(datanames, replace[i], replacements[i])
}
  #apply finalnames to totaldata
colnames(totaldata) <- finalnames

#PRINT FINAL DATASET
print(totaldata)
  
#CREATE SECOND TIDY DATA WITH AVERAGE OF EACH VARIABLE BY EACH ACTIVITY & SUBJECT (requirement 5)
tidydata <- totaldata %>%
  group_by(Subject, Labels) %>% #group by subject then by activity
  summarise_all("mean") %>% #find means
  ungroup() #put back into table

#PRINT TIDYDATA
print(tidydata)
