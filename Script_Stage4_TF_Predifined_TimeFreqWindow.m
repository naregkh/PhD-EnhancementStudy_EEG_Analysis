%% Script Stage 4 power statistics

% % What this code does 
% take TF data and compares time and powere windows acorss the conditions 
% it test the hypothesis that power within the time and power window is the
% same acorss conditions 

% % Main functions used here 
% Extract_Power.m
% Extract_Power_wrapper.m

% % Input data
% it uses the TF structures which are saved in Script_Stage3_TF_Decomposition


% [Tf] = Extract_Power(TF,t,f); % general format

% load nareg-eeg-functions
addpath('C:\Users\abpt242\Documents\MATLAB\nareg-eeg-functions-20190415')

%% Load the TF data
path = 'Data_TF\';
Files2Read = ls([path,'*.mat']);
for Fidx = 1:size(Files2Read,1)
load([path,Files2Read(Fidx,:)]);
end
clearvars Fidx path Files2Read


%% Currently reporting content below in the papers/powerpoint 

%% Parietal electrodes gamma 
t = [140 250]; f = [31 90];
TF_P_high.clim = [-1 1]; % set colour limit of the plot
[position3,graph2] = Extract_Power_wrapper(802,'Parietal (P-z12)',TF_P_high,t,f);
graph2.Position(3) = position3; % to align the figures since the legend on the side distracts
% Savefigure_nk('Figures\TF\predefined\Pariatal_gamma')

[TF_P_high_1,TF_P_high_2] = SeparatePerCondition(TF_P_high);
[position3,graph2] = Extract_Power_wrapper(802,'Parietal (P-z12)',TF_P_high_1,t,f);
graph2.Position(3) = position3; % to align the figures since the legend on the side distracts

[position3,graph2] = Extract_Power_wrapper(802,'Parietal (P-z12)',TF_P_high_2,t,f);
graph2.Position(3) = position3; % to align the figures since the legend on the side distracts


%% Frontal electrodes 
% theta, later 
t = [900 1190]; % time window
f = [3 7]; % frequency band
TF_F_low.clim = [-1 1]; % set colour limit of the plot
[position3,graph2] = Extract_Power_wrapper(141,'Frontal (F-z12)',TF_F_low,t,f);
graph2.Position(3) = position3; % to align the figures since the legend on the side distracts

[TF_F_low_1,TF_F_low_2] = SeparatePerCondition(TF_F_low);
[position3,graph2] = Extract_Power_wrapper(141,'Frontal (F-z12)',TF_F_low_1,t,f);
graph2.Position(3) = position3; 

[position3,graph2] = Extract_Power_wrapper(141,'Frontal (F-z12)',TF_F_low_2,t,f);
graph2.Position(3) = position3; 

% theta, earlier 
t = [50 420]; % time window
f = [4 9]; % frequency band
TF_F_low.clim = [-1 1]; % set colour limit of the plot
[position3,graph2] = Extract_Power_wrapper(805,'Frontal (F-z12)',TF_F_low,t,f);
graph2.Position(3) = position3; % to align the figures since the legend on the side distracts

% beta 
t = [170 670]; % time window
f = [10 16]; % frequency band
TF_F_low.clim = [-1 1]; % set colour limit of the plot
[position3,graph2] = Extract_Power_wrapper(806,'Frontal (F-z12)',TF_F_low,t,f);
graph2.Position(3) = position3; % to align the figures since the legend on the side distracts

%% not reporting the rest in the chapter

%% Occipital electrode gamma
t = [140 225]; f = [49  78];
TF_O_high.clim = [-1 1]; % set colour limit of the plot
[position3,graph2] = Extract_Power_wrapper(801,'Occipital (O-z12)',TF_O_high,t,f);
graph2.Position(3) = position3; % to align the figures since the legend on the side distracts
Savefigure_nk('Figures\TF\predefined\Occipital_gamma')


%% Central electrodes gamma 
t = [140 250]; f = [31 90];
TF_C_high.clim = [-1 1]; % set colour limit of the plot
[position3,graph2] = Extract_Power_wrapper(803,'Central (P-z12)',TF_C_high,t,f);
graph2.Position(3) = position3; % to align the figures since the legend on the side distracts

%% Parietal electrodes
% beta 
t = [700 900]; % time window
f = [10 17]; % frequency band
TF_P_low.clim = [-2 2]; % set colour limit of the plot
[position3,graph2] = Extract_Power_wrapper(807,'Parietal (P-z12)',TF_P_low,t,f);
graph2.Position(3) = position3; % to align the figures since the legend on the side distracts


%% end 
