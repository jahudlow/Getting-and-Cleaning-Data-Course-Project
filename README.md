# Getting-and-Cleaning-Data-Course-Project
This script runs a brief analysis on data collected from an experiment involving samsung galaxy s smartphones. The data were obtained from 30 volunteers who wore waist-mounted phones while doing six different activities. The data were downloaded from the UCI website and saved into the working directory from where the script is intended to run.

The first thing the script does is read several sets of data into R from their files in the working directory. It then merges together the corresponding data on the features, subject and activity data sets from the test and train folders. The subject and activity data sets are then named. 

The labels for the features data are read into R next and used to name them. After this the three individual components are merged together by column into one dataframe using cbind.

The measures for mean and standard deviation are extracted from the rest of the data using the grep function and this becomes the primary data set. Next the activity labels are read in from the working directory and the gsub function is used to insert them into the data set in place of the number labels. The labels for the features are then changed from abbreviations to descriptive names with full words. 

The last step completed by the script is to create an independent tidy data set with the average of each variable for each activity and subject. The tidy data set is written into a new text file in the working directory.

