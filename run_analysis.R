# Author: Jasmine Ratchford
# Date: 2017-05-20
# Title: Class Project
# Instructions:
#1) Merges the training and the test sets to create one data set.
#2) Extracts only the measurements on the mean and standard deviation for each measurement.
#3) Uses descriptive activity names to name the activities in the data set
#4) Appropriately labels the data set with descriptive variable names.
#5) From the data set in step 4, creates a second, independent tidy data \
# set with the average of each variable for each activity and each subject.


#
#The submitted data set is tidy.
#The Github repo contains the required scripts.
#GitHub contains a code book that modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information.
#The README that explains the analysis files is clear and understandable.
#The work submitted for this project is the work of the student who submitted it.

###############################################
## FUNCTIONS TO HELP OUT

mergeData<-function(aid="Activity", sid="SubjectID",  testSetNameX='data/test/X_test.txt'
                     ,trainingSetNameX='data/train/X_train.txt'
                     ,testSetNameY='data/test/y_test.txt'
                     ,trainingSetNameY='data/train/y_train.txt'
                     ,testSetNameS='data/test/subject_test.txt'
                     ,trainingSetNameS='data/train/subject_train.txt')
{
  
  #1) Merges the training and the test sets to create one data set.
  # Remember to check dimensions first.
  # I did that.
  
  xtest<-read.delim(testSetNameX, sep='', header=FALSE,strip.white=TRUE, as.is=TRUE)
  xtrain<-read.delim(trainingSetNameX, sep='', header=FALSE,strip.white=TRUE, as.is=TRUE)
  
  ytest<-read.delim(testSetNameY, sep='', header=FALSE,strip.white=TRUE, as.is=TRUE)
  ytrain<-read.delim(trainingSetNameY, sep='', header=FALSE,strip.white=TRUE, as.is=TRUE)
  names(ytest)<-c(aid)
  names(ytrain)<-c(aid)
  subject_test<-read.delim(testSetNameS, sep='', header=FALSE,strip.white=TRUE, as.is=TRUE)
  subject_train<-read.delim(trainingSetNameS, sep='', header=FALSE,strip.white=TRUE, as.is=TRUE)
  names(subject_test)<-c(sid)
  names(subject_train)<-c(sid)
  
  # Assume rows line up ( no  other way)
  # Rbind after C bind to make sure that data is aligned
  merged<-rbind(cbind(xtest,ytest,subject_test),cbind(xtrain,ytrain, subject_train))
  
}



cleanf<-function(label1)
{
  #2 This is for cleaning data labels.
  # The order of the information can be easily changed here
  if(is.na(label1))
  {# In case something goes really wrong
    print(' Bad Label')
    return(0)
  }
  #  cleanupFeaturesgsub('(\d,\d)gsub('\\(\\)','',x),'-')
  m<-gregexpr("([A-z0-9]+|(\\d+\\,\\d+))",label1)
  label<-regmatches(label1,m)[[1]]
  if(is.na(label[1]))
    {# Unable to clean label
    return(label1)
  }
  m2<-gregexpr('([A-Z][a-z]+)\\1*',label[1])
  type<-regmatches(label[1],m2)[[1]]
  
  if(! exists('type') |length(type)==0 |is.na(type[1]))
  {
    return(label1)
  }
  if (! is.na(label[1]) &substr(label[1],1,1)=='f')
    { # Rewrite out the fourier transform and time omponents
    mdomain<-'fouriertransform'
    } 
  else if (! is.na(label[1]) & substr(label[1],1,1)=='t')
  {
    mdomain<-'time'
  }
  else {
    mdomain<-'UNK'
  }
  
  vartype<-label[2]
  aType<-type[1] # acceleration type (body gravity, bodybody(?))
  aType<-if(length(type)>=3 &type[3]=='Jerk') paste(c(aType,"Jerk"),collapse="") else aType
  equipType<-if(type[2]=="Acc") "Accelerometer" else "Gyroscope" # acceleration type (Gyro, Accelerometer)
  mag<-if(length(type)>=3 &type[length(type)]=='Mag') "Magnitude" else if (length(label)>=3) label[3] else '?'
  paste(c(equipType,mdomain,aType, vartype,mag), collapse=' ')
}


##################################################################
# BEGIN SCRIPT

#-------------------------
# Preliminary work.
#read in activity labels
activityLabels<-read.csv('data/activity_labels.txt',sep=' ',skip=0, as.is=TRUE, header=FALSE,col.names=c('label','activity'))
features<-read.csv('data/features.txt', sep=' ',header=FALSE,col.names=c('label','feature'),as.is=TRUE)
#############
## Define what you want to call these two rows
aid<-"Activity"
sid<-"SubjectID"

#------------------------------
#1) Merges the training and the test sets to create one data set.
# The below uses rbind and cbind

  data<-mergeData(aid=aid,sid=sid)
#-------------------------------
#2 Extracts only the measurements on the mean and standard deviation for each measurement.

#It is unclear to me whether we want al the mean frequency or not
wantedFeatures<-features$label[grep('(mean|std)\\(\\)',features$feature)]

# This version retains the meanFreq
#wantedFeatures<-features$label[grep('(mean|std)',features$feature)]
hold<-data[,c(aid,sid)]
data<-data[,c(features$label[wantedFeatures])]
  
#--------------------------------
#3 Desribe Activities
hold['Activity']<-sapply(hold['Activity'], FUN=function(x){activityLabels$activity[x]})

#---------------------------------
#4) Appropriately labels the data set with descriptive variable names.
# This is rather subjective. I think these names are fine
names(data)<-sapply(features$feature[wantedFeatures],cleanf)

#Was separated for a bit, but put it back together now
data<-cbind(data,hold)
#---------------------------------
#5) From the data set in step 4, creates a second, independent tidy data \
# set with the average of each variable for each activity and each subject.

library(tidyr)
library(dplyr)

# Gather the data by measurement, value (ignore Activity and subjectID)
tidy<-gather(data,key=Measurement, value=value, -get(aid),-get(sid)) %>% group_by_(aid,sid, 'Measurement') %>% summarise(mean=mean(value))%>% spread_(aid,'mean')
write.table(tidy,file='my_clean_data.txt',sep=',', row.names=FALSE)

