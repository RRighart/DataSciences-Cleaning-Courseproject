DataSciences-Cleaning-Courseproject
==========================================================
==========================================================
run_analysis.R
author: R. Righart
date: 2014-10-26
data: Human Activity Recognition Using Smartphones Dataset
==========================================================

## LOAD DATA
The datasets loaded are three sets for the training
and testdata each, including a vector with subject numbers,
a vector with activity-levels and the X datasets. The X_train 
and X_test sets are the sets that contain the measurement data.

## 1. MERGE TRAINING AND TEST SET TO CREATE ONE DATASET
The train and test set are merged (using rbind). This results 
in the total set (tset), containing 10299 rows and 561 columns. 
Similarly, corresponding datasets are merged for subject and 
activity_labels. Merging of these columns with the tset is done 
at a later stage (see ## 4.)

## 2. EXTRACT ONLY THE MEASURES ON THE MEAN AND SD FOR EACH 
MEASUREMENT
The features.txt file provides the 561 names and are put 
in the object FT. The requested features (mean and std 
measures) are taken using grep and the appropriate elements
are put in a new object called nFT (for naming) and ntset 
(measurement data).

## 3. DESCRIPTIVE ACTIVITY NAMES
Activity labels are attributed using a factor command that 
replaces its the values by the six corresponding labels.

## 4. DATASET LABELLED WITH DESCRIPTIVE VARIABLE NAMES
The variables are renamed with descriptive variable names, 
using the names function. At this stage the subject and
activity_labels column are added as well. 

## 5. CREATION OF SECOND INDEPENDENT TIDY DATASET
For the creation of a second independent dataset the plyr 
package is used. The function ddply calculates the average 
of each variable for each activity and each subject. This 
results in a new dataset called tidyset with 180 rows 
(i.e., subjects [30] * activity_levels [6]) and 81 columns 
(i.e., measurement variable, plus tset$subjects and 
tset$activity_labels). Using write.table this set is saved 
as a txt file called tidydata.txt.

==========================================================




  

