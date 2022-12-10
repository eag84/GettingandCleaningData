# GettingandCleaningData

Hi! 

This project contains two files: run_analysis.R and Variables.txt

I created a script called run_analysis.R that does the following things:
1) Uploads test and training data from wearable computing data
(please see: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones and here are the data for the project: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
2) Extracts the variables of interest (standard deviations and means). I chose to have a wide dataset with subject and activity as rows. Each column containing a value with a designation from each of the following permutations:
-Time vs Frequency
-Body vs Gravity
-Linear Acceleration vs Angular velocity
-Magnitude vs Jerk (may not be specified)
-X, Y, Z axis (may not be specified)
3) Combines selected testing and training data into one set with all 30 participants
3) Uses descriptive activity names to name the activities in the data set:
(WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
4) Labels the data set with descriptive variable names
5) Creates a tidy dataset of means of each value organized by the 30 participants and the activity during which measurements were taken

For a list of all variables included in the final output, please see Variables.txt