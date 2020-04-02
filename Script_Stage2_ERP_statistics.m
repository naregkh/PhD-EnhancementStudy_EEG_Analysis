% Script to do stats on ERPs, 
% make meaningful figures with stuff ...
% https://garstats.wordpress.com/2016/04/02/simple-steps-for-more-informative-erp-figures/
% could add something about what proportion of participants show that
% effect
Initialise

%% using the ERP_stats_v2 plots both ERPs and compares them correcting for mutiple comparison across time (not region since we assume we are looking at the regions)
load([cd '\Data_ERPs\Automatic_2_VisObs.mat'])

% n_permutes  = 10000; % n of permutation
n_permutes  = 10000; % n of permutation

left=1000; bottom=400; width=600; height=400;

channels    = {'F1', 'Fz', 'F2'};
figure(141); set(gcf, 'Position',  [left,bottom,width,height]), clf 
ERP_stats_v3(EEG,ERP_Hs,ERP_CRs,'Hits','CRs',channels,n_permutes)
Savefigure_nk('Figures\ERP\Frontal_all')

channels    = {'FC1', 'FC2','FC3', 'FC4'};
figure(142); clf
ERP_stats_v2(EEG,ERP_Hs,ERP_CRs,'Hits','CRs',channels,n_permutes)

channels    = {'P1', 'Pz', 'P2'};
figure(143); set(gcf, 'Position',  [left,bottom,width,height]), clf 
ERP_stats_v3(EEG,ERP_Hs,ERP_CRs,'Hits','CRs',channels,n_permutes)
Savefigure_nk('Figures\ERP\Parietal_all')

% channels    = {'PO3', 'POz', 'PO4'};
% figure(144); set(gcf, 'Position',  [left,bottom,width,height]), clf 
% ERP_stats_v2(EEG,ERP_Hs,ERP_CRs,'Hits','CRs',channels,n_permutes)
% Savefigure_nk('Figures_ERP\Parieto-Occipital')

% channels    = {'O1', 'Oz', 'O2'};
% figure(145); set(gcf, 'Position',  [left,bottom,width,height]), clf 
% ERP_stats_v3(EEG,ERP_Hs,ERP_CRs,'Hits','CRs',channels,n_permutes)
% Savefigure_nk('Figures\ERP\Occipital_all')


%% compare across condiitons: plot two conditions in the same plot 
% showing the breakdown of the two conditions that show an effect. 

left=300; bottom=250; width=600*2; height=400;

channels    = {'P1', 'Pz', 'P2'};
figure(245); clf;  
set(gcf, 'Position',  [left,bottom,width,height]), clf 

ERP_stats_dirtywayleft(EEG,ERP_Hs(:,:,retrieval),ERP_CRs(:,:,retrieval),'Hits','CRs',channels,n_permutes)
ERP_stats_dirtywayright(EEG,ERP_Hs(:,:,reactivation),ERP_CRs(:,:,reactivation),'Hits','CRs',channels,n_permutes)

Savefigure_nk('Figures\ERP\Parietal_both')


%% Compare across conditions: plot one per condition 

load 'Z:\Nareg_Experiment2\BehaviouralAnalysis\BehData.mat' T % load beh data, get the conditions data 
retrieval       = logical(T.Condition([13:25,27:end]));
reactivation    = T.Condition([13:25,27:end])==0;

channels    = {'F1', 'Fz', 'F2'};
figure(241); clf;  set(gcf, 'Position',  [left,bottom,width,height]), clf 
ERP_stats_v3(EEG,ERP_Hs(:,:,retrieval),ERP_CRs(:,:,retrieval),'Hits','CRs',channels,n_permutes)
Savefigure_nk('Figures\ERP\Frontal_Retrieval')
figure(242); clf;  set(gcf, 'Position',  [left,bottom,width,height]), clf 
ERP_stats_v3(EEG,ERP_Hs(:,:,reactivation),ERP_CRs(:,:,reactivation),'Hits','CRs',channels,n_permutes)
Savefigure_nk('Figures\ERP\Frontal_Photo')


channels    = {'P1', 'Pz', 'P2'};
figure(243); clf;  set(gcf, 'Position',  [left,bottom,width,height]), clf 
ERP_stats_v3(EEG,ERP_Hs(:,:,retrieval),ERP_CRs(:,:,retrieval),'Hits','CRs',channels,n_permutes)
Savefigure_nk('Figures\ERP\Parietal_Retrieval')
figure(244); clf;  set(gcf, 'Position',  [left,bottom,width,height]), clf 
ERP_stats_v3(EEG,ERP_Hs(:,:,reactivation),ERP_CRs(:,:,reactivation),'Hits','CRs',channels,n_permutes)
Savefigure_nk('Figures\ERP\Parietal_Photo')


channels    = {'PO3', 'POz', 'PO4'};
figure(245); clf;  set(gcf, 'Position',  [left,bottom,width,height]), clf 
ERP_stats_v3(EEG,ERP_Hs(:,:,retrieval),ERP_CRs(:,:,retrieval),'Hits','CRs',channels,n_permutes)
Savefigure_nk('Figures\ERP\Par-Occi_Retrieval')
figure(246); clf;  set(gcf, 'Position',  [left,bottom,width,height]), clf 
ERP_stats_v3(EEG,ERP_Hs(:,:,reactivation),ERP_CRs(:,:,reactivation),'Hits','CRs',channels,n_permutes)
Savefigure_nk('Figures\ERP\Par-Occi_Photo')


channels    = {'O1', 'Oz', 'O2'};
figure(247); clf;  set(gcf, 'Position',  [left,bottom,width,height]), clf 
ERP_stats_v3(EEG,ERP_Hs(:,:,retrieval),ERP_CRs(:,:,retrieval),'Hits','CRs',channels,n_permutes)
Savefigure_nk('Figures\ERP\Occipital_Retrieval')
figure(248); clf;  set(gcf, 'Position',  [left,bottom,width,height]), clf 
ERP_stats_v3(EEG,ERP_Hs(:,:,reactivation),ERP_CRs(:,:,reactivation),'Hits','CRs',channels,n_permutes)
Savefigure_nk('Figures\ERP\Occipital_Photo')

