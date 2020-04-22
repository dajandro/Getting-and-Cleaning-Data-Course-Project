# Project Code Book

## Source dataset (Input)

The data is collected from the accelerometers from the Samsung Galaxy S smartphone.
A brief description from the README source file:
> The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
>
> The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details.
>
> Notes:
> - Features are normalized and bounded within [-1,1].
> - Each feature vector is a row on the text file.

You can download the data here: [Download data source](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip, "Download")

A full description is available at the site where the data was obtained: [Data source](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones "Human Activity Recognition Using Smartphones")

## Tidy dataset (Output)

The tidy dataset have the following structure:

<table>
  <tr>
    <th>Name</th>
    <th>Type</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>ACTIVITY</td>
    <td>Factor</td>
    <td>Different types of activities recorded from the sensors</td>
  </tr>
  <tr>
    <td>SUBJECT ID</td>
    <td>Numeric</td>
    <td>Identification of the subject from who the measurements were taken</td>
  </tr>
  <tr>
    <td>VARIABLE</td>
    <td>Factor</td>
    <td>Name of the selected features that come from the accelerometer and gyroscope 3-axial raw signals</td>
  </tr>
  <tr>
    <td>AVERAGE</td>
    <td>Numeric</td>
    <td>Average of the values from the activity, subject and feature</td>
  </tr>
</table>

Follow this steps to tranform the source data into this tidy dataset:
1. Merge the training and the test sets to create one data set
    1. Read files from train and test directories
    2. Merge them in one dataframe
2. Extract only the measurements on the mean and standard deviation for each measurement
    1. Use regular expressions to select the measurements
    2. Subset using logical vector
3. Create a second, independent tidy data set with the average of each variable for each activity and each subject
    1. Melt the dataframe using the Activity and Subject ID as ids
    2. Summarize the variables using the mean function
