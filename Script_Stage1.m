%% Study 3 / reactivation & retrieval practice @ British Museum  (January 2019)
%% ScriptStage 1

% improve recipe for cleaning data, encorporating ICA for ocular correction

% Pipeline information

%   Load
%   Channel Location
%   Downsample to 256
% % Save Raw data - 01_raw

%   remove flatlines, remove
%   run ICA
% % Save cleaned data with ICAs - 02_clean
%
%   ICA ocular correction
%   plot clear/dirty data
%   delete eye electrode
%   interpolate the bad channels
% % Save cleaned ICA-ed - 03_ica

%   Re-reference to average
% % Save final continues data 04_final

%   Rename Triggers
%   Epoch all trials


%% initialise EEGlab and functions
Initialise


%% Get names for loading

% Read file names of BrainVision
path_BVA  = 'Z:\Nareg_Experiment2\EEG_Data\RawData\'; % where BVA files are
FileNames = ls([path_BVA,'*.vhdr']);

% choose who to exclude (also exclude things to be appended, the appended
% files to be added in later
Files2Exclude = {'R_15_1.vhdr','R_20.vhdr'}; % 15_1 will be appended, 20 matlab crashed

% Delete the file extensions % Exclude participants
for pre_i = 1:length(FileNames)
    if pre_i ==1
        FileNames_cell = cell(length(FileNames)-length(Files2Exclude),1);
        post_i = 0;
    end
    if ~strcmp(strtrim(FileNames(pre_i,:)),Files2Exclude)
        post_i = post_i+1;
        FileNames_cell(post_i) = regexp(FileNames(pre_i,:),'\d*','Match');
    end
end
FileNames = char(FileNames_cell);

N = length(FileNames); % N
diary Script_Stage1_v2_Diary

t_0 = tic;
for subji = 1:N
    %% Loading - also appends the files that are in two parts (18 secs)
    t(1) = tic;
    EEG = pop_loadbv(path_BVA, ['R_', strtrim(FileNames(subji,:)), '.vhdr']); % if pop_loadbv is not found, add the extention in gui
    % Load channal locations
    EEG = pop_chanedit(EEG, 'lookup','C:\\Users\\abpt242\\Documents\\MATLAB\\eeglab14_1_1b\\plugins\\dipfit2.3\\standard_BESA\\standard-10-5-cap385.elp');
    
    % If the files need appending a secondary file - only data in out case
    if strcmp(strtrim(['R_',FileNames(subji,:)]),'R_15')
        EEG_Apend = pop_loadbv(path_BVA, 'R_15_1.vhdr'); % if pop_loadbv is not found, add the extention in gui
        EEG = pop_mergeset( EEG, EEG_Apend );                                                                                                                                                                                                                                                                                                                                                                                  EEG_new = pop_mergeset(EEG,EEG_Apend);
    end
    disp(['* Loaded ', num2str(subji), ' from BVA [', num2str(round(toc(t(1)))),' sec]'])
    
    %% Downsample to 256 Hz (~5-20 seconds)
    tic;
    EEG = pop_resample( EEG, 256 );
    disp(['* pop_resample ', num2str(subji), ' [', num2str(round(toc)),' sec]'])
    
    %% Save raw data
    subjname = strtrim(FileNames(subji,:));
    subjname = pad(subjname,2,'left','0'); % add zeros to left side
    save(['Data_Prep_Automatic_2\01_raw\',subjname],'EEG')
    
    %% This function removes flatline channels, low-frequency drifts, noisy channels, short-time bursts,
    % also uses ASR (automatic subspace reconstruction)
    % and incompletely repaird segments from the data. (~40-90 secs)
    tic;
    originalEEG  = EEG; % this is later used for interpolation (and ploting)
    arg_flatline = 5;
    arg_highpass = [.25 .75]; % the filter is 1 Hz 
    arg_channel  = .85 ; %'off'; % ;
    arg_noisy    = 4;
    arg_burst    = 5; %  'off';
    arg_window   = .25;
    EEG = clean_artifacts(EEG, 'FlatlineCriterion', arg_flatline,...
        'Highpass',          arg_highpass,...
        'ChannelCriterion',  arg_channel,...
        'LineNoiseCriterion',  arg_noisy,...
        'BurstCriterion',    arg_burst,...
        'WindowCriterion',   arg_window);
    disp(['* clean_artifacts ', num2str(subji), ' [', num2str(round(toc)),' sec]'])
    
    %% run ICA
    tic
    EEG = pop_runica(EEG, 'extended',1,'interupt','off');
    disp(['* ICA took ', num2str(subji), ' [', num2str(round(toc)),' sec]'])

    %% Save Cleaned data (with ICA components)
    subjname = strtrim(FileNames(subji,:));
    subjname = pad(subjname,2,'left','0'); % add zeros to left side
    % Save the preprocessed epoched data
    save(['Data_Prep_Automatic_2\02_cleaned\',subjname],'EEG')
    
    %% Occular correction with ICA
    % on epoched, resampled data takes about 4/5 mins
    % works well for removing ocular artifact rejection
    tic
    EEG = pop_autobsseog( EEG, [516], [516], 'sobi', {'eigratio', [1000000]}, 'eog_fd', {'range',[2  21]});
    disp(['* ICA occular correction ', num2str(subji), ' [', num2str(round(toc)),' sec]'])

    %     TODO: delete ICA related data ( in a more elaborate way)
    EEG.icaact = []; % cleaning the ica data
    EEG.icawinv = [];
    EEG.icasphere = [];
    EEG.icaweights = [];
    EEG.icachansind = [];
    disp(['* Occular correction ', num2str(subji), ' [', num2str(round(toc)),' sec]'])

    %% save Cleaned & ica-ed data
    subjname = strtrim(FileNames(subji,:));
    subjname = pad(subjname,2,'left','0'); % add zeros to left side
    % Save the preprocessed epoched data
    save(['Data_Prep_Automatic_2\03_ica\',subjname],'EEG')
    
    %% Plot the clear and dirty (very very dirty) data on top of eachother
    %     EEG.filename = strtrim(FileNames(subji,:));
    %     TSubset = [105 110];
    %     WLength = TSubset(2) - TSubset(1);
    %     vis_artifacts(EEG,originalEEG,'show_setname','true','YRange',[0 1],'WindowLength',WLength,'TimeSubset',TSubset)
    %     vis_artifacts(EEG,originalEEG,'show_setname','true')
    
    %% Delete eye electrode (and earlobe electrodes) before interpolation
    % this will cause an error if placed before vis_artifacts()
%     EEG = pop_select( EEG,'nochannel',{'AF7','PO10','PO9'});
    EEG = pop_select( EEG,'nochannel',{'AF7','TP10','TP9'}); % this should be the correct code
    
    %% Interpolate bad channels (and also the eye electrode frankly... and even the PO9 and PO10 which I excluded)
    % ~19 seconds
    t = tic;
    EEG = pop_interp(EEG, originalEEG.chanlocs, 'spherical');
    disp(['* pop_interp ', num2str(subji), ' [', num2str(round(toc(t))),' sec]'])

    %% Save final continues data before referencing and epoching 
    subjname = strtrim(FileNames(subji,:));
    subjname = pad(subjname,2,'left','0'); % add zeros to left side
    % Save the preprocessed epoched data
    save(['Data_Prep_Automatic_2\04_final\',subjname],'EEG')
    
    %% Re reference
    % ~20 seconds
    %     EEG = pop_reref( EEG, [35 36] ); % Earlobe re-reference
    t = tic;
    EEG = pop_reref( EEG, [] ); % Average re-reference
    disp(['* pop_reref ', num2str(subji), ' [', num2str(round(toc(t))),' sec]'])
    
    %% Trigger business
    % we have three triggers for each trial, the last one contains confidence, second one contain response, first one is the stimulus, here we add
    % that information to the first (stimuli) trigger, so we can forget
    % about the last two triggers when epoching.
    t = tic;
    if subji==1; BehData_EEG = cell(N); Resp_EEG = zeros(N,6); end
    [EEG,BehData_EEG(subji),Resp_EEG(subji,:)] = Func_Triggers(EEG);
    
    %% Epoching
    markers = {'CR_1','CR_2','CR_3','CR_4','CR_5','CR_6','CR_7',...
        'FA_1','FA_2','FA_3','FA_4','FA_5','FA_6','FA_7',...
        'M_1','M_2','M_3','M_4','M_5','M_6','M_7',...
        'H_1','H_2','H_3','H_4','H_5','H_6','H_7'};
    EEG = pop_epoch( EEG, markers, [-1  2], 'epochinfo', 'yes');
    disp(['* pop_epoch ', num2str(subji), ' [', num2str(round(toc(t))),' sec]'])
    
    %% Saving the preprocessed and epoched data
    subjname = strtrim(FileNames(subji,:));
    subjname = pad(subjname,2,'left','0'); % add zeros to left side
    
    % Save the preprocessed epoched data - saves in matlab format 
    save(['Data_Prep_Automatic_2\',subjname],'EEG')
    
%     % Save the preprocessed epoched data - saves in EEGlab format - this
%     syntax doesnt work 
%     pop_saveset(EEG,'filename',subjname,'filepath','Z:\Nareg_Experiment2\EEG_Analysis\Matlab\Data_Prep_Automatic_2\05_epoched_set-files')

    
    %%
    disp(['Participant ', num2str(subji), ' out of ', num2str(N), ' completed in ', num2str(round(toc(t(1))/60)), ' Mins'])
    
end % end of the loop

% % Save the repsonses collected from EEG data made this for cross checking,
% It's a very paranoid sanity check, it is not complete at the moment (only
% has subjects until 30)
save('ResponsesEEG','BehData_EEG','Resp_EEG') 

t_0=toc(t_0);
disp(['Entire thing completed in ', num2str(round(t_0/60)), ' Mins'])
