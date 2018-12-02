##### Peer graded Assignment 

library(dplyr)
library(data.table)
library(readr)
library(reshape2)
library(reshape)

install.packages("reshape")

features <- read.table('C:/Users/andym/Desktop/Data_Science_SPecialisation/Getting and Cleaning Data/Week 4/Submission project/UCI HAR Dataset/features.txt')
Activity_list <- read.table('C:/Users/andym/Desktop/Data_Science_SPecialisation/Getting and Cleaning Data/Week 4/Submission project/UCI HAR Dataset/activity_labels.txt')
feature_info <- read.table('C:/Users/andym/Desktop/Data_Science_SPecialisation/Getting and Cleaning Data/Week 4/Submission project/UCI HAR Dataset/features.txt',header = FALSE)


subject_train <- read.table('C:/Users/andym/Desktop/Data_Science_SPecialisation/Getting and Cleaning Data/Week 4/Submission project/UCI HAR Dataset/train/subject_train.txt')
train_data <-read.table('C:/Users/andym/Desktop/Data_Science_SPecialisation/Getting and Cleaning Data/Week 4/Submission project/UCI HAR Dataset/train/X_train.txt')
train_label <- read.table('C:/Users/andym/Desktop/Data_Science_SPecialisation/Getting and Cleaning Data/Week 4/Submission project/UCI HAR Dataset/train/y_train.txt',header = FALSE)

subject_test <- read.table('C:/Users/andym/Desktop/Data_Science_SPecialisation/Getting and Cleaning Data/Week 4/Submission project/UCI HAR Dataset/test/subject_test.txt')
test_data <- read.table('C:/Users/andym/Desktop/Data_Science_SPecialisation/Getting and Cleaning Data/Week 4/Submission project/UCI HAR Dataset/test/x_test.txt')
test_label <- read.table('C:/Users/andym/Desktop/Data_Science_SPecialisation/Getting and Cleaning Data/Week 4/Submission project/UCI HAR Dataset/test/y_test.txt')


colnames(Activity_list) <- c('Activity List','Activity Name')
colnames(Activity_list)



colnames(train_label) <- 'Activity' 
colnames(train_data) <- features[,2]
colnames(subject_train) <- 'Subject_ID'
train_data <- train_data[,grep("mean()|std()",colnames(train_data))]




colnames(test_label) <- 'Activity' 
colnames(test_data) <- features[,2]
colnames(subject_test) <- 'Subject_ID'
test_data <- test_data[,grep("mean()|std()",colnames(test_data))]



cbind_Train<- cbind(subject_train,train_data,train_label)
cbind_Test <- cbind(subject_test,test_data,test_label)
 
complete_Data <- rbind(cbind_Train,cbind_Test)



complete_Data$Activity <- factor(complete_Data$Activity,labels = c("LAYING" ,"SITTING" , "STANDING" ,"WALKING" ,"WALKING_DOWNSTAIRS" ,"WALKING_UPSTAIRS"))



tidy_data <- melt(complete_Data, id = c("Activity","Subject_ID"))

tidy_data <- dcast(tidy_data, Activity + Subject_ID ~ variable,mean)

colnames(tidy_data)


glimpse(tidy_data)
write.csv(tidy_Data,"Tidy_Data.csv")
