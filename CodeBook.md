# CODEBOOK
# NEW DATA - Summary of old data summary statistics (mean and standard deviation)

# ROWS: Represent Activity, Subject observation
# COLUMNS: Represent mean of summary statistics observed by an accelerometer and a gyroscope.



#Column Definitions.
* SubjectID - INTEGER- (1,30) : Identifies subject in study
* Activity : Identifies the activity values: "LAYING"  "SITTING"  "STANDING" "WALKING" "WALKING_DOWNSTAIRS" "WALKING_UPSTAIRS"  
 Each measurement column has a 5-word description:
 Word 1:  Identifies the instrument making the measurement  : values- Acclerometer or Gyroscope 
 Word 2:  Identifies the dimensions and domain of the measurement (frequency or time): values-  fouriertransform or time 
 Word 3:  Identifies the measurement: Values -Body , BodyBody , Gravity ( with the addition of Jerk to indicate a Jerk quantity)
 Word 4:  Identifies the summary statistic: values - mean or std
 word 5:  Identifies the vector dimension (or magnitude): values - X, Y, Z or Magnitude
 

For example the first few are:
               
"Accelerometer fouriertransform Body mean Magnitude" - "from Accelerometer , fourier transform of the Body acceleration, mean statistic (magnitude)"
"Accelerometer fouriertransform Body mean X"        -"from Accelerometer , fourier transform of the Body acceleration, mean statistic (X-direction)"
"Accelerometer fouriertransform Body mean Y"           -"from Accelerometer , fourier transform of the Body acceleration, mean statistic(Y-direction)"
"Gyroscope fouriertransform Body std X"        -" from Gyroscope, fourier transform of the Body acceleration, standard deviation statistic (X-direction)"
"Gyroscope time BodyJerk std Y"          -" from Gyroscope, BodyJerk acceleration, standard deviation statistic (Y-direction)"
"Gyroscope time BodyJerk std Z" -" from Gyroscope, BodyJerk acceleration, standard deviation statistic (Z-direction)"

The values in the data are the mean of the summary statistic.
# What I did to the data

1) I kept only the mean and standard deviation
2) I updated the remaining variable names to a more readable format.
3) I added the activity by adding the activity ID and them transforming that into the actual activity
4) I summarized the data such that only the mean of all observations for a particular measurement, person, and activity are kept


# Original data  Acceleration from Gyroscope and Accelerometer 

 561 Measurement variables
 30 participants
 10299 distinct data points

The purpose of this project is to demonstrate ability to collect, work with, and clean a data set. 
The goal is to prepare tidy data that can be used for later analysis. 
You will be graded by your peers on a series of yes/no questions related to the project. 
You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 
3) a code book that describes the variables,
 the data, and any transformations or work that you performed to clean up the data called CodeBook.md. 
You should also include a README.md in the repo with your scripts. 
This repo explains how all of the scripts work and how they are connected.

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

 