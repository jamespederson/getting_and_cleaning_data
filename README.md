Script: run_analysis.R
Getting and Cleaning Data Course Project - This script will demonstrate a working
    understanding of the concepts learned in the course.

The following is an explanation as how the script runs

a) First set a working directory and download the dataset zip file
b) Unzip the dataset file and read in all the different files with train and test attributes
     i. Activity attributes
     ii. Subject attributes
     iii. Features attributes
c) Merge the datasets using rbind and cbind
d) Subset the data and extract measurements on the mean and standard deviation for each measurement
e) Use global subtitute to use descriptive names
f) Create a final tidy dataset
