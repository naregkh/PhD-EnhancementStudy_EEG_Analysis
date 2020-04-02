# PhD Enhancement Study EEG Analysis

Codes here were used for preprocessing and analysis of the EEG data collected during my last PhD project. The recognition task during which this data was collected is stored [here](https://github.com/naregkh/PhD-EnhancementStudy_ExperimentScript.git). 


### Initialise.m 
Sets up the EEGlab and my own [tools](https://github.com/naregkh/PhD-EnhancementStudy_EEG_Analysis_tools) in the path and startes EEGlab. It also tells EEGlab to use double precision.

## Preprocessing

### Script_Stage1.m 
This script performs preprocessing on the EEG data collected with BrainVision amplifiers. 
Preprocsseing stesp are as following
Set Channel Location
Downsample to 256
Remove flatlines and slow drifts 
run ICA
ICA ocular correction
plot clear/dirty data (optional)
delete ocullar channal 
interpolate the bad channels (and also eye channal)
Re-reference to average
Rename Triggers
Epoch all trials

## For ERP analysis.

### Script_Stage2_ERP.m 
Apply lowpass filter on the on the continues data, then average them across the conditions creating the Event-Related potentials. 
Plots grand averages.

### Script_Stage2_ERP_statistics.m
Plot the ERPs and compare them across the conditions. Using ERP_stats_v3 from HYPERLINK

### Script_Stage2_ERP_statistics_GroupComparison.m
Plot the ERPs and compare them across the conditions between the participants.

## For TF analysis.

### Script_Stage2_Save_Epochs_Per_Condition 
Saves epoched data for the TF analysis. 

### Script_Stage3_TF_Decomposition
Performs TF decomposition.

### Script_Stage4_TF_Find_Significant_Clusters
For when there is no prediction about the time and frequency of the effect. Cluster-size based analysis finds effects by controling for multiple comaprison tests. 

### Script_Stage4_TF_Predifined_TimeFreqWindow
For when there is a prediction about the time and frequency of the effect. 
