Getting and cleaning data. Course project.
============================================

## Variables selection

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist.

Using its embedded accelerometer and gyroscope, we captured 3-axial raw signals at a constant rate of 50 Hz (tAcc-XYZ and tGyro-XYZ), these is time domain signals (prefix 't' to denote time). Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals).

## Variables

> Subject

Subject number who perfomed the activity.
Value: [1...30]

> Activity

Description of activity.
Value: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, 
SITTING, STANDING, LAYING.

> Time domain variables

Value: [-1, 1]

|     Mean              | Standard deviation    |
|:---------------------:|:---------------------:|
|tbodyacc.mean.x  	|tbodyacc.std.x	      |
|tbodyacc.mean.y	      |tbodyacc.std.y   	|
|tbodyacc.mean.z	      |tbodyacc.std.z   	|
|tgravityacc.mean.x	|tgravityacc.std.x	|
|tgravityacc.mean.y	|tgravityacc.std.y	|
|tgravityacc.mean.z	|tgravityacc.std.z	|
|tbodyaccjerk.mean.x	|tbodyaccjerk.std.x	|
|tbodyaccjerk.mean.y	|tbodyaccjerk.std.y	|
|tbodyaccjerk.mean.z	|tbodyaccjerk.std.z	|
|tbodygyro.mean.x	      |tbodygyro.std.x  	|
|tbodygyro.mean.y	      |tbodygyro.std.y  	|
|tbodygyro.mean.z	      |tbodygyro.std.z  	|
|tbodygyrojerk.mean.x	|tbodygyrojerk.std.x	|
|tbodygyrojerk.mean.y	|tbodygyrojerk.std.y	|
|tbodygyrojerk.mean.z	|tbodygyrojerk.std.z	|
|tbodyaccmag.mean	      |tbodyaccmag.std  	|
|tgravityaccmag.mean	|tgravityaccmag.std	|
|tbodyaccjerkmag.mean	|tbodyaccjerkmag.std	|
|tbodygyromag.mean	|tbodygyromag.std	      |
|tbodygyrojerkmag.mean	|tbodygyrojerkmag.std	|



> Frequency domain variables

Value: [-1, 1]

|     Mean              | Standard deviation    |
|:---------------------:|:---------------------:|
|fbodyacc.mean.x	      |fbodyacc.std.x	      |
|fbodyacc.mean.y  	|fbodyacc.std.y   	|
|fbodyacc.mean.z	      |fbodyacc.std.z   	|
|fbodyaccjerk.mean.x	|fbodyaccjerk.std.x	|
|fbodyaccjerk.mean.y	|fbodyaccjerk.std.y	|
|fbodyaccjerk.mean.z	|fbodyaccjerk.std.z	|
|fbodygyro.mean.x	      |fbodygyro.std.x  	|
|fbodygyro.mean.y	      |fbodygyro.std.y  	|
|fbodygyro.mean.z	      |fbodygyro.std.z  	|
|fbodyaccmag.mean	      |fbodyaccmag.std	      |
|fbodyaccjerkmag.mean	|fbodyaccjerkmag.std	|
|fbodygyromag.mean	|fbodygyromag.std	      |
|fbodygyrojerkmag.mean	|fbodygyrojerkmag.std	|
