% Script to do stats on ERPs, 
% make meaningful figures with stuff ...
% https://garstats.wordpress.com/2016/04/02/simple-steps-for-more-informative-erp-figures/
% could add something about what proportion of participants show that
% effect

%% this is the second version of the initial code, it has less crap in it.
% the aim is to compare the conditions, ignore running a test on all
% condition

Initialise

%% using the ERP_stats_v2 plots both ERPs and compares them correcting for mutiple comparison across time (not region since we assume we are looking at the regions)
load([cd '\Data_ERPs\Automatic_2_VisObs.mat'])

% n_permutes  = 10000; % n of permutation
n_permutes  = 10000; % n of permutation

sf=.8;

left=-1300; bottom=250; width=600*2*sf; height=400*sf;

%% compare across condiitons: plot two conditions in the same plot 
% showing the breakdown of the two conditions that show an effect. 

load 'Z:\Nareg_Experiment2\BehaviouralAnalysis\BehData.mat' T % load beh data, get the conditions data 
% 26th is the person (ID 28) with no EEG data, so excluding that row from beh data 
% if replace 1 with 13 it will be data from subjescts excluding those filtered
retrieval       = logical(T.Condition([1:25,27:end])); 
reactivation    = T.Condition([1:25,27:end])==0;


%% % % % % % % fronto-central % % % % % % 

% channels    = {'Fz', 'F1', 'F2', 'FC1', 'FC2', 'Cz', 'C1', 'C2'};
channels    = {'Fz', 'FC1', 'FC2' }; % yeh
figure(101); clf;  
set(gcf, 'Position',  [left,bottom,width,height]), clf 

ERP_stats_dirtywayleft(EEG,ERP_Hs(:,:,retrieval),ERP_CRs(:,:,retrieval),'Hits','CRs',channels,n_permutes)
ERP_stats_dirtywayright(EEG,ERP_Hs(:,:,reactivation),ERP_CRs(:,:,reactivation),'Hits','CRs',channels,n_permutes)

% Savefigure_nk('Figures\ERP\fronto-central_both')
 
%% % % % % % % Parietal % % % % % % 

channels    = {'P1', 'Pz', 'P2'}; % yeh

figure(102); clf;  
set(gcf, 'Position',  [left,bottom,width,height]), clf 

ERP_stats_dirtywayleft(EEG,ERP_Hs(:,:,retrieval),ERP_CRs(:,:,retrieval),'Hits','CRs',channels,n_permutes)
ERP_stats_dirtywayright(EEG,ERP_Hs(:,:,reactivation),ERP_CRs(:,:,reactivation),'Hits','CRs',channels,n_permutes)

% Savefigure_nk('Figures\ERP\Parietal_both')



