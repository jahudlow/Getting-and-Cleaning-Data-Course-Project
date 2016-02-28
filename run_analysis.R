# Read the data from the files in the working directory
test_data<-read.table("UCI HAR Dataset/test/X_test.txt")
train_data<-read.table("UCI HAR Dataset/train/X_train.txt")
subject_test<-read.table("UCI HAR Dataset/test/subject_test.txt")
subject_train<-read.table("UCI HAR Dataset/train/subject_train.txt")
activity_test<-read.table("UCI HAR Dataset/test/y_test.txt")
activity_train<-read.table("UCI HAR Dataset/train/subject_train.txt")

# Merge the appropriate data from different folders together by rows
all_x_data<-rbind(test_data,train_data)
all_subject<-rbind(subject_test,subject_train)
all_activity<-rbind(activity_test,activity_train)

# Name the subject and Activity
names(all_subject)<-c("subject")
names(all_activity)<-c("activity")

# Read the features labels from wd
labels<-read.table("UCI HAR Dataset/features.txt")
names(all_x_data)<-labels$V2

# Merge the dataframes together by columns
all_data<-cbind(all_x_data,all_subject,all_activity)

# Extract the measures of mean and standard deviation
sub_labels<-labels$V2[grep("-mean\\(\\)|-std\\(\\)",labels$V2)]
label_names_subset<-c(as.character(sub_labels),"subject","activity")
all_data2<-subset(all_data,select=label_names_subset)

# Read activity labels from wd and apply them to activities in the data set
activity_labels<-read.table("UCI HAR Dataset/activity_labels.txt")
all_data2$activity<-gsub("1","WALKING",all_data2$activity)
all_data2$activity<-gsub("2","WALKING_UPSTAIRS",all_data2$activity)
all_data2$activity<-gsub("3","WALKING_DOWNSTAIRS",all_data2$activity)
all_data2$activity<-gsub("4","SITTING",all_data2$activity)
all_data2$activity<-gsub("5","STANDING",all_data2$activity)
all_data2$activity<-gsub("6","LAYING",all_data2$activity)

# Label data set with descriptive names
names(all_data2)<-gsub("^t", "time", names(all_data2))
names(all_data2)<-gsub("^f", "frequency", names(all_data2))
names(all_data2)<-gsub("Acc", "Accelerometer", names(all_data2))
names(all_data2)<-gsub("Gyro", "Gyroscope", names(all_data2))
names(all_data2)<-gsub("Mag", "Magnitude", names(all_data2))
names(all_data2)<-gsub("BodyBody", "Body", names(all_data2))
names(all_data2)<-gsub("std", "standardDeviation", names(all_data2))

# Create independent tidy data set with average of each variable for each activity and subject
tidy_data<-aggregate(. ~subject + activity, all_data2, mean)
tidy_data2<-tidy_data[order(tidy_data$subject,tidy_data$activity),]
write.table(tidy_data2,file="tidy_data.txt",row.name=FALSE)
