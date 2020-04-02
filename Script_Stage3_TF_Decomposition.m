%% Does tf and some fancy pants plots - very efficiently !
% (improved recipe, now tastes even better) uses the TF struct files 

% % What this code does
% Computes time-frequency decomposition with complext morlet wave convolution 
% Save the TF structures 

% % functions used
% TF_wrapper.m
% TF_Decomposition.m

% % Input data
% Requires the epoched per condition data 
% see Script_Stage2_Save_Epochs_Per_Condition

%% Nareg's functions
addpath('C:\Users\abpt242\Documents\MATLAB\nareg-eeg-functions-20190415')


%% Have a delightful moment and think about the structures that are used here and thank your previous self 
% the TF structures contain 
% 'params'      - structure which contains the infromation about
%                 frequency decomposition (struct)
% TF matrices   - these 3D matrices are named after the condition (ALL, Hits, CRs)
%                 these matrices are frequency by times by participants (double)
% 'freq'        - the frequency indices (double)
% 'times'       - the time indices (double)
% 'channels'    - name of the channels the data is from (cell)


%% Get the data to decompose 
cd 'Z:\Nareg_Experiment2\EEG_Analysis\Matlab' % this line is fing stupid 

path = 'Z:\Nareg_Experiment2\EEG_Analysis\Matlab\Data_Epoched\';

FileNames = ls([cd '\Data_Epoched\All\' '*.mat']);
% Only load unfiltered data (or only those that were not filtered the shit out of)
% R_14 & later participants data is not filtered 
FileNames = FileNames(13:end,:); 

% we make the TF files which like EEGlabs EEG files will contain data and information about the TF data 
% define parameters for tm decomposition

high_params.min_freq = 30;
high_params.max_freq = 100; % potentially increase % potentially 100 is goot 
% high_params.num_frex = 40;
high_params.num_frex = 70;
% high_params.cycles = 7; % makes little sense to use 7 here but end the
% lower bands cycles with 10, change either 
high_params.cycles = 10;
% high_params.type = 'PhaseLocked';
high_params.type = 'NonPhaseLocked';

low_params.min_freq = 2;
low_params.max_freq = 30;
low_params.num_frex = 40;
low_params.cycles = [2 10];
% low_params.type = 'PhaseLocked';
low_params.type = 'NonPhaseLocked';

% % It's stupid, we dont need them all (or maybe we do(n't))
% [each subject ~6 seconds
% TF_Decomposition_wrapper takes ~  


%% % each TF takes around 2 minutes

TF_O_low.channels = {'Oz'  'O1'  'O2'};
TF_O_low    = TF_Decomposition_wrapper(TF_O_low,FileNames,path,low_params);

TF_PO_low.channels = {'POz'  'PO3'  'PO4'};
TF_PO_low   = TF_Decomposition_wrapper(TF_PO_low,FileNames,path,low_params);

TF_P_low.channels = {'Pz'  'P1'  'P2'};
TF_P_low    = TF_Decomposition_wrapper(TF_P_low,FileNames,path,low_params);

TF_C_low.channels = {'Cz'  'C1'  'C2'};
TF_C_low    = TF_Decomposition_wrapper(TF_C_low,FileNames,path,low_params);

TF_F_low.channels = {'Fz'  'F1'  'F2'};
TF_F_low    = TF_Decomposition_wrapper(TF_F_low,FileNames,path,low_params);

save('Data_TF\TF_O_low' ,'TF_O_low')
save('Data_TF\TF_PO_low','TF_PO_low')
save('Data_TF\TF_P_low' ,'TF_P_low')
save('Data_TF\TF_C_low' ,'TF_C_low')
save('Data_TF\TF_F_low' ,'TF_F_low')
disp('* low bands completed')


TF_O_high.channels = {'Oz'  'O1'  'O2'};
TF_O_high   = TF_Decomposition_wrapper(TF_O_high,FileNames,path,high_params);

TF_P_high.channels = {'Pz'  'P1'  'P2'};
TF_P_high   = TF_Decomposition_wrapper(TF_P_high,FileNames,path,high_params);

TF_PO_high.channels = {'POz'  'PO3'  'PO4'};
TF_PO_high  = TF_Decomposition_wrapper(TF_PO_high,FileNames,path,high_params);

TF_C_high.channels = {'Cz'  'C1'  'C2'};
TF_C_high   = TF_Decomposition_wrapper(TF_C_high,FileNames,path,high_params);

TF_F_high.channels = {'Fz'  'F1'  'F2'};
TF_F_high   = TF_Decomposition_wrapper(TF_F_high,FileNames,path,high_params);

save('Data_TF\TF_O_high' ,'TF_O_high')
save('Data_TF\TF_PO_high','TF_PO_high')
save('Data_TF\TF_P_high' ,'TF_P_high')
save('Data_TF\TF_C_high' ,'TF_C_high')
save('Data_TF\TF_F_high' ,'TF_F_high')

disp('* high bands completed')

% for left and right parietal alpha beta 
TF_PL_low.channels = {'P3'  'P5'  'P7'};
TF_PL_low    = TF_Decomposition_wrapper(TF_PL_low,FileNames,path,low_params);
save('Data_TF\TF_PL_low' ,'TF_PL_low')

TF_PR_low.channels = {'P2'  'P4'  'P6'};
TF_PR_low    = TF_Decomposition_wrapper(TF_PR_low,FileNames,path,low_params);
save('Data_TF\TF_PR_low' ,'TF_PR_low')



%%                      %%
        % Archive % 
%% % Grouping electrodes like Guber 2008
% gourping more generously

TF_Frontal_low.channels = {'Fp1','Fp2','AF3','AF4','F1','Fz','F2'};
TF_Frontal_low    = TF_Decomposition_wrapper(TF_Frontal_low,FileNames,path,low_params);
save('Data_TF\TF_Frontal_low' ,'TF_Frontal_low')

TF_Central_low.channels = {'FC1','FC2','C1','Cz','C2','CP1','CPz','CP2'};
TF_Central_low    = TF_Decomposition_wrapper(TF_Central_low,FileNames,path,low_params);
save('Data_TF\TF_Central_low' ,'TF_Central_low')

TF_Poster_low.channels = {'P1','P2','Pz','PO3','POz','PO4','O1','Oz','O2'};
TF_Poster_low    = TF_Decomposition_wrapper(TF_Poster_low,FileNames,path,low_params);
save('Data_TF\TF_Poster_low'  ,'TF_Poster_low')
disp('** high bands completed')


TF_Frontal_high.channels = {'Fp1','Fp2','AF3','AF4','F1','Fz','F2'};
TF_Frontal_high    = TF_Decomposition_wrapper(TF_Frontal_high,FileNames,path,high_params);
save('Data_TF\TF_Frontal_high' ,'TF_Frontal_high')

TF_Central_high.channels = {'FC1','FC2','C1','Cz','C2','CP1','CPz','CP2'};
TF_Central_high    = TF_Decomposition_wrapper(TF_Central_high,FileNames,path,high_params);
save('Data_TF\TF_Central_high' ,'TF_Central_high')

TF_Poster_high.channels = {'P1','P2','Pz','PO3','POz','PO4','O1','Oz','O2'};
TF_Poster_high    = TF_Decomposition_wrapper(TF_Poster_high,FileNames,path,high_params);
save('Data_TF\TF_Poster_high'  ,'TF_Poster_high')
disp('** low bands completed')



%% The Entire spectrum!
params.min_freq = 4;
params.max_freq = 100; % potentially increase 
params.num_frex = 80;
params.cycles = [2 10];
% high_params.type = 'PhaseLocked';
params.type = 'NonPhaseLocked';

TF_O.channels = {'Oz'  'O1'  'O2'};
TF_O    = TF_Decomposition_wrapper(TF_O,FileNames,path,params);
TF_PO.channels = {'POz'  'PO3'  'PO4'};
TF_PO   = TF_Decomposition_wrapper(TF_PO,FileNames,path,params);
TF_P.channels = {'Pz'  'P1'  'P2'};
TF_P    = TF_Decomposition_wrapper(TF_P,FileNames,path,params);
TF_C.channels = {'Cz'  'C1'  'C2'};
TF_C    = TF_Decomposition_wrapper(TF_C,FileNames,path,params);
TF_F.channels = {'Fz'  'F1'  'F2'};
TF_F    = TF_Decomposition_wrapper(TF_F,FileNames,path,params);

save('Data_TF\TF_O' ,'TF_O')
save('Data_TF\TF_PO','TF_PO')
save('Data_TF\TF_P' ,'TF_P')
save('Data_TF\TF_C' ,'TF_C')
save('Data_TF\TF_F' ,'TF_F')
disp('* all bands completed')

disp('all done')

%% The famous figure
figure(10); clf
subplot(211)
TF_O_high.clim = [-1 1]; % set colour limit of the plot
TF_Plot(mean(TF_O_high.ALL,3),TF_O_high,'Occipital (O-z12)')
t = [180 255]; % time window
f = [45  80]; % frequency band
Plot_DrawPeakArea(t,f)

subplot(212)
TF_F_low.clim = [-3 3]; % set colour limit of the plot
TF_Plot(mean(TF_F_low.ALL,3),TF_F_low,'Frontal (F,z12)')
t = [300 500]; % time window
f = [3 7]; % frequency band
Plot_DrawPeakArea(t,f)

%% lots of plots not very useful 

% the Frontal high & low 
figure(12); clf
subplot(211)
TF_F_high.clim = [-1 1]; % set colour limit of the plot
TF_Plot(mean(TF_F_high.ALL,3),TF_F_high,'Frontal (F-z12)')

subplot(212)
TF_F_low.clim = [-3 3]; % set colour limit of the plot
TF_Plot(mean(TF_F_low.ALL,3),TF_F_low,' ')

% the C high low 
figure(13); clf
subplot(211)
TF_C_high.clim = [-1 1]; % set colour limit of the plot
TF_Plot(mean(TF_C_high.ALL,3),TF_C_high,'Central (C-z12)')

subplot(212)
TF_C_low.clim = [-3 3]; % set colour limit of the plot
TF_Plot(mean(TF_C_low.ALL,3),TF_C_low,' ')

% the P high low 
figure(14); clf
subplot(211)
TF_P_high.clim = [-1 1]; % set colour limit of the plot
TF_Plot(mean(TF_P_high.ALL,3),TF_P_high,'Parietal (P-z12)')

subplot(212)
TF_P_low.clim = [-3 3]; % set colour limit of the plot
TF_Plot(mean(TF_P_low.ALL,3),TF_P_low,' ')

% the O high low 
figure(15); clf
subplot(211)
TF_O_high.clim = [-1 1]; % set colour limit of the plot
TF_Plot(mean(TF_O_high.ALL,3),TF_O_high,'Occipital (O-z12)')

subplot(212)
TF_O_low.clim = [-3 3]; % set colour limit of the plot
TF_Plot(mean(TF_O_low.ALL,3),TF_O_low,' ')

%% End
