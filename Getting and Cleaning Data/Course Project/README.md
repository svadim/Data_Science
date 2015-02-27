Getting and cleaning data. Course project.
============================================

This project serves to demonstrate the collection and cleaning of a tidy data set that can be used for subsequent analysis.

### Data set.

 [Human Activity Recognition database] (https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.

The dataset includes the following files:

* 'README.txt'

* 'features_info.txt': Shows information about the variables used on the feature vector.

* 'features.txt': List of all features.

* 'activity_labels.txt': Links the class labels with their activity name.

* 'train/X_train.txt': Training set.

* 'train/y_train.txt': Training labels.

* 'test/X_test.txt': Test set.

* 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent.

* 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

* 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

* 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

* 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.

### Script.

1.  Download the data.
2.  Read the data.
3.  Merge the training and the test sets.
4.  Add the variable names to the dataset.
5.  Extract only the mean and standard deviation measurements.
6.  Add the activity names and the subject to the dataset.
7.  Clean up the columns names.
8.  Find the mean for each variable for each subject and activity.
9.  Write the summary data to a text file.
10. Clean up workspace.

* run_analysis.R