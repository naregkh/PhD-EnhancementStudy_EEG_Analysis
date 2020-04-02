%% Study 2 / Oscillation study (January 2019)
% Saving epoched per condition data so it can be loaded and fasten the process of TF
% analysis


%% start eeglab and my functions
Initialise


%% Load continues data and save epoched data [2.5 ~ minutes]

% Path to epoched to all data
% path            = 'C:\Users\abpt242\OneDrive - City, University of London\MemoryProject\Data_Analysis\Frequency_Analysis_2019\Data_Prep_Automatic_VisObs\';
path            = 'Z:\Nareg_Experiment2\EEG_Analysis\Matlab\Data_Prep_Automatic_2_VisObs\';
FileNames       = ls([cd '\Data_Prep_Automatic_2_VisObs\*.mat']);

markers_all  = {'H_1' ,'H_2' ,'H_3' ,'H_4' ,'H_5' ,'H_6' ,'H_7' , 'CR_1','CR_2','CR_3','CR_4','CR_5','CR_6','CR_7'};
markers_Hits = {'H_1' ,'H_2' ,'H_3' ,'H_4' ,'H_5' ,'H_6' ,'H_7' };
markers_CRs  = {'CR_1','CR_2','CR_3','CR_4','CR_5','CR_6','CR_7'};

SaveEpoches(path,FileNames,'Data_Epoched\All\',markers_all) % it's stupid to take all epoches and save it again 
SaveEpoches(path,FileNames,'Data_Epoched\Hits\',markers_Hits)
SaveEpoches(path,FileNames,'Data_Epoched\CRs\',markers_CRs)
