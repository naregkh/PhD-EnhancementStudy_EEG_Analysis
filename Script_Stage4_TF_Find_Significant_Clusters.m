%% cluster-based perumation test
% to find clusters time-frequency of difference between Hits and Correct Rejections

%% load my functions
addpath('C:\Users\abpt242\Documents\MATLAB\nareg-eeg-functions-20190415')
addpath('Z:\Nareg_Experiment2\EEG_Analysis\Matlab\Functions')

% British Museum


%% load the TF files
path = 'Data_TF\';
Files2Read = ls([path,'*.mat']);
for Fidx = 1:size(Files2Read,1)
    load([path,Files2Read(Fidx,:)]);
end
clearvars Fidx path Files2Read

%%
% TODO add titles to thes poor figures!!! APA DOESNT NEED TITLES 

figure(11),clf, TF_Cluster_Based_Permutation_v2(TF_F_high)
figure(12),clf, TF_Cluster_Based_Permutation_v2(TF_F_low)

% figure(14),clf, TF_Cluster_Based_Permutation_v2(TF_C_high)
% figure(15),clf, TF_Cluster_Based_Permutation_v2(TF_C_low)

% figure(17),clf, TF_Cluster_Based_Permutation_v2(TF_P_high)
% figure(18),clf, TF_Cluster_Based_Permutation_v2(TF_P_low)

figure(20),clf, TF_Cluster_Based_Permutation_v2(TF_PO_high) % gamma (cluster size)
figure(21),clf, TF_Cluster_Based_Permutation_v2(TF_PO_low)

% figure(23),clf, TF_Cluster_Based_Permutation_v2(TF_O_high)
% figure(24),clf, TF_Cluster_Based_Permutation_v2(TF_O_low)

%% for BACN poster 
figure(2022),clf, TF_Cluster_Based_Permutation_v2_ForPoster(TF_PO_high) % gamma (cluster size)
figure(2023),clf, TF_Cluster_Based_Permutation_v2_ForPoster(TF_P_low)   % beta ()


%% Looking across conditions 

% Frontal 
[TF_F_high_1,TF_F_high_2] = SeparatePerCondition(TF_F_high);
figure(111),clf, TF_Cluster_Based_Permutation_v2(TF_F_high_1) % retriaval
figure(112),clf, TF_Cluster_Based_Permutation_v2(TF_F_high_2) % reactivation  % gamma ;)

[TF_F_low_1,TF_F_low_2] = SeparatePerCondition(TF_F_low);
figure(111),clf, TF_Cluster_Based_Permutation_v2(TF_F_low_1) % retriaval
figure(112),clf, TF_Cluster_Based_Permutation_v2(TF_F_low_2) % reactivation  
%
% % 
% [TF_C_high_1,TF_C_high_2] = SeparatePerCondition(TF_C_high);
% figure(111),clf, TF_Cluster_Based_Permutation_v2(TF_C_high_1) % retriaval
% figure(112),clf, TF_Cluster_Based_Permutation_v2(TF_C_high_2) % reactivation

[TF_P_high_1,TF_P_high_2] = SeparatePerCondition(TF_P_high);
figure(111),clf, TF_Cluster_Based_Permutation_v2(TF_P_high_1) % retriaval
figure(112),clf, TF_Cluster_Based_Permutation_v2(TF_P_high_2) % reactivation

[TF_PO_high_1,TF_PO_high_2] = SeparatePerCondition(TF_PO_high);
figure(111),clf, TF_Cluster_Based_Permutation_v2(TF_PO_high_1) % retriaval
figure(112),clf, TF_Cluster_Based_Permutation_v2(TF_PO_high_2) % reactivation  % gamma

[TF_O_high_1,TF_O_high_2] = SeparatePerCondition(TF_O_high);
figure(111),clf, TF_Cluster_Based_Permutation_v2(TF_O_high_1) % retriaval
figure(112),clf, TF_Cluster_Based_Permutation_v2(TF_O_high_2) % reactivation


%% archive
% Grouped like Guber 2008
figure(10), clf, TF_Cluster_Based_Permutation_v2(TF_Frontal_low)
figure(11), clf, TF_Cluster_Based_Permutation_v2(TF_Central_low)
figure(12), clf, TF_Cluster_Based_Permutation_v2(TF_Poster_low)

figure(13), clf, TF_Cluster_Based_Permutation_v2(TF_Frontal_high) % early gamma
figure(14), clf, TF_Cluster_Based_Permutation_v2(TF_Central_high)
figure(15), clf, TF_Cluster_Based_Permutation_v2(TF_Poster_high) % later gamma



