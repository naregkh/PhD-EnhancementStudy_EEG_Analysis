%% Study 2 / Oscillation study (January 2019)
%% ScriptStage 2 - epoch ERPs save them (dont forget to name them properly in save) plots per participants and per individual,
% exclude participants, 


%% initialise EEGlab and functions
Initialise


%% Extract participants ERPs: Import data, 30Hz highcut, & calculate grand averages

%% Paths to Pre-processed data
% path = 'Data_Prep_Automatic\';
% path = 'Data_Prep_Automatic_2\';
path = 'Data_Prep_Automatic_2_VisObs\';
FileNames = ls([cd filesep path '*.mat']);

% FileNames = FileNames(indexofcontrols,:); % if only certain subjects are
% wanted

%% Load a file to get size for creating the empty matrices (~ 2 mins)
% Load all (including to-be-excluded)
markers_Hits = {'H_1' ,'H_2' ,'H_3' ,'H_4' ,'H_5' ,'H_6' ,'H_7' };
markers_CRs  = {'CR_1','CR_2','CR_3','CR_4','CR_5','CR_6','CR_7'};

t(1) = tic;
for subji = 1:size(FileNames,1)
    t(2)=tic;
    
    load([path,(FileNames(subji,:))]); % to use the EEG.nbchan and EEG.pnts
    
    if subji==1 % initialise the ERP_Hs etc...
        ERP_Hs   = zeros(EEG.nbchan,EEG.pnts,size(FileNames,1));
        ERP_CRs  = zeros(EEG.nbchan,EEG.pnts,size(FileNames,1));
        ERP_diff = zeros(EEG.nbchan,EEG.pnts,size(FileNames,1)); %#ok<PREALL>
    end
    
    %     EEG = pop_rmbase( EEG, [-500    0]); % baseline correction
    EEG = pop_rmbase( EEG, [-200    0]); % baseline correction
    EEG = pop_eegfiltnew(EEG, 'hicutoff',30); % what is the slope?
    
    [EEG_Hs] = pop_epoch( EEG, markers_Hits, [-1  2], 'epochinfo', 'yes');
    ERP_Hs(:,:,subji) = mean(EEG_Hs.data,3);
    
    [EEG_CR] = pop_epoch( EEG, markers_CRs, [-1  2], 'epochinfo', 'yes');
    ERP_CRs(:,:,subji) = mean(EEG_CR.data,3);
    
    disp(['* iteration ' num2str(subji) ' out of ' num2str(size(FileNames,1)) ' [' num2str(toc(t(2))) ' seconds]'])
end

ERP_diff = ERP_CRs - ERP_Hs; % Calculate difference between old and new

save('Data_ERPs/Automatic_2_VisObs','ERP_Hs','ERP_CRs','ERP_diff','FileNames','EEG')
% save('Data_ERPs/Automatic_2','ERP_Hs','ERP_CRs','ERP_diff','FileNames','EEG')
ERP_Hs_all      = ERP_Hs;
ERP_CRs_all     = ERP_CRs;
ERP_diff_all    = ERP_diff;
FileNames_all   = FileNames;

disp(['loading, epoching, & filtering took ' num2str(toc(t(1))) ' seconds'])

%% Files to exclude
% Files2Exclude = {'17.mat','23.mat','24.mat','25.mat','26.mat','30.mat'};
Files2Exclude = {'17.mat','23.mat','24.mat','25.mat'}; % noisy data 

Files2Exclude = {'15.mat','17.mat','18.mat','19.mat','22.mat','24.mat','30.mat','26.mat'}; % + stuff that don't show ERPs per subject

for subji = 1:size(FileNames,1)
    if (subji==1)
        FileNames_cell = cell(length(FileNames)-length(Files2Exclude),1);
        i=0;
    end
    if~(strcmp(FileNames(subji,:),Files2Exclude))
        i = i+1;
        Excludeinx(subji) = 1;
    else
        Excludeinx(subji) = 0;
    end
end
Excludeinx = logical(Excludeinx);

ERP_Hs      = ERP_Hs(:,:,Excludeinx);
ERP_CRs     = ERP_CRs(:,:,Excludeinx);
ERP_diff    = ERP_diff(:,:,Excludeinx);
FileNames   = FileNames(Excludeinx,:);


%%
%     figure; pop_topoplot(EEG_Hs,1, 0:25:400 ,' resampled epochs',[2 10] ,0,'electrodes','on');
%     figure; pop_topoplot(EEG_CR,1, 0:25:400 ,' resampled epochs',[2 10] ,0,'electrodes','on');

%%
channels        = {'O1' 'Oz' 'O2' 'PO3' 'POz' 'PO4' 'P1' 'Pz' 'P2' 'F1' 'Fz' 'F2'};
channelgroups   = {'O'  'O'  'O'  'PO'  'PO'  'PO'  'P'  'P'  'P'  'F'  'F'  'F' };
colour          = {'r'  'r'  'r'  'm'   'm'   'm'   'c'  'c'  'c'  'b'  'b'  'b' };


%% Plot per participant ERPs: Hits, CR, difference
% set outside the function
%     EEG = EEG; % for chan locations and times

figure(2); clf
Plot_ERPs(ERP_Hs,EEG,channels,FileNames,'Hits ',colour)

figure(3); clf
Plot_ERPs(ERP_CRs,EEG,channels,FileNames,'CR ',colour)

figure(4); clf
Plot_ERPs(ERP_diff,EEG,channels,FileNames,'CR - Hits ',colour)


%% Plot grand average ERP (separate electrodes)

channels   = {'O1' 'Oz' 'O2' 'PO3' 'POz' 'PO4' 'P1' 'Pz' 'P2' 'F1' 'Fz' 'F2'}';
colour     = {'r'  'r'  'r'  'm'   'm'   'm'   'c'  'c'  'c'  'b'  'b'  'b' };

figure(6); clf
% subplot(2,2,1)
Plot_ERP(ERP_Hs,EEG,channels,'Hit',colour,{'off'})

figure(7); clf
% subplot(2,2,2)
Plot_ERP(ERP_CRs,EEG,channels,'CR',colour,{'off'})

figure(8); clf
% subplot(2,2,3)
Plot_ERP(ERP_diff,EEG,channels,'Diff',colour,[])


%% Plot grand average ERP (group electrodes)

channels   = ...
    {'O1' 'Oz'  'O2'  ''
    'PO3' 'POz' 'PO4' ''
    'P1'  'Pz'  'P2'  ''
    'F1'  'Fz'  'F2'  ''};
chanlegend = {'O'  'PO' 'P' 'F'};
colour     = {'r'  'm'  'c'  'b'};

figure(9); clf
% subplot(2,2,1)
Plot_ERP(ERP_Hs,EEG,channels,'Hit',colour,{'off'})
figure(10); clf

% subplot(2,2,2)
Plot_ERP(ERP_CRs,EEG,channels,'CR',colour,{'off'})
figure(11); clf

% subplot(2,3,5)
Plot_ERP(ERP_diff,EEG,channels,'Diff',colour,chanlegend)

