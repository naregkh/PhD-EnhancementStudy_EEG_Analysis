%% Initialise the basics

%% Start EEGlab
addpath('C:\Users\abpt242\Documents\MATLAB\eeglab14_1_2b')
addpath('C:\Users\N\Documents\MATLAB\toolbox\eeglab14_1_2b')

% nareg-eeg-functions for general EEG analysis 
addpath('C:\Users\abpt242\Documents\MATLAB\nareg-eeg-functions-20190415')

% nareg functions specific to this analysis
addpath([cd '\Functions'])


[ALLEEG, EEG, CURRENTSET, ALLCOM] = eeglab;
% eeglab('nogui'); % faster to run eeglab without gui, not everything is
% loaded though

% set eeglab to use double percision numbers 
pop_editoptions('option_single', 0);





