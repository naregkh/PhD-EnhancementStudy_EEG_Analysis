
sf = .8;
% left=-1300; bottom=250; width=600*2*sf; height=400;
left=300; bottom=250; width=600*2*sf; height=400;


%% Frontal
% High - photo review % gamma
[TF_F_high_1,TF_F_high_2] = SeparatePerCondition(TF_F_high);
figure(101), set(gcf, 'Position',  [left,bottom,width,height]), clf 

subplot(121); 
TF_Cluster_Based_Permutation_v2_ForPoster(TF_F_high_1) % retriaval practice 
title('Retrieval Practice')
subplot(122);
TF_Cluster_Based_Permutation_v2_ForPoster(TF_F_high_2) % reactivation / photo review % gamma
title('Photo Review')
% Savefigure_nk('Figures\TF\clusters\Frontal_Both_high')

%% Low - no theta 
[TF_F_low_1,TF_F_low_2] = SeparatePerCondition(TF_F_low);
figure(102), set(gcf, 'Position',  [left,bottom,width,height]), clf 

subplot(121); 
TF_Cluster_Based_Permutation_v2_ForPoster(TF_F_low_1) % retriaval practice 
title('Retrieval Practice')
subplot(122);
TF_Cluster_Based_Permutation_v2_ForPoster(TF_F_low_2) % reactivation / photo review
title('Photo Review')
% Savefigure_nk('Figures\TF\clusters\Frontal_Both_low')

%% %% Pariatal 
% % High
% [TF_P_high_1,TF_P_high_2] = SeparatePerCondition(TF_P_high);
% figure(103), set(gcf, 'Position',  [left,bottom,width,height]), clf 
% 
% subplot(121); 
% TF_Cluster_Based_Permutation_v2_ForPoster(TF_P_high_1) % retriaval practice 
% title('Retrieval Practice')
% subplot(122);
% TF_Cluster_Based_Permutation_v2_ForPoster(TF_P_high_2) % reactivation / photo review 
% title('Photo Review')

% Savefigure_nk('Figures\TF\clusters\Parietal_Both_high')


% % low
% [TF_P_low_1,TF_P_low_2] = SeparatePerCondition(TF_PO_low);
% figure(113), set(gcf, 'Position',  [left,bottom,width,height]), clf 
% 
% subplot(121); 
% TF_Cluster_Based_Permutation_v2_ForPoster(TF_P_low_1) % retriaval practice 
% title('Retrieval Practice')
% subplot(122);
% TF_Cluster_Based_Permutation_v2_ForPoster(TF_P_low_2) % reactivation / photo review % gamma
% title('Photo Review')

% Savefigure_nk('Figures\TF\clusters\Parietal_Both_low')


%% Pariatal-Occipital 
% High - photo review % gamma, but wierd though 

[TF_PO_high_1,TF_PO_high_2] = SeparatePerCondition(TF_PO_high);
figure(104), set(gcf, 'Position',  [left,bottom,width,height]), clf 

subplot(121); 
TF_Cluster_Based_Permutation_v2_ForPoster(TF_PO_high_1) % retriaval practice 
title('Retrieval Practice')
subplot(122);
TF_Cluster_Based_Permutation_v2_ForPoster(TF_PO_high_2) % reactivation / photo review % gamma
title('Photo Review')

% Savefigure_nk('Figures\TF\clusters\Parieto-Occipital_Both_high')


% % Low
% figure(130),clf, TF_Cluster_Based_Permutation_v2_ForPoster(TF_PO_low)
% [TF_PO_low_1,TF_PO_low_2] = SeparatePerCondition(TF_PO_low);
% figure(131),clf, TF_Cluster_Based_Permutation_v2_ForPoster(TF_PO_low_1) % retriaval
% figure(132),clf, TF_Cluster_Based_Permutation_v2_ForPoster(TF_PO_low_2) % reactivation  

%% parietal alpha beta, nothing on left or right. 
[TF_PR_low_1,TF_PR_low_2] = SeparatePerCondition(TF_PR_low);
figure(104), set(gcf, 'Position',  [left,bottom,width,height]), clf 

subplot(121); 
TF_Cluster_Based_Permutation_v2_ForPoster(TF_PR_low_1) % retriaval practice 
title('Retrieval Practice')
subplot(122);
TF_Cluster_Based_Permutation_v2_ForPoster(TF_PR_low_2) % reactivation / photo review % gamma
title('Photo Review')

% Savefigure_nk('Figures\TF\clusters\Parieto-Occipital_Both_high')



%% Occipital  
% High
figure(120),clf, TF_Cluster_Based_Permutation_v2_ForPoster(TF_O_high) % gamma (cluster size)
[TF_O_high_1,TF_O_high_2] = SeparatePerCondition(TF_O_high);
figure(121),clf, TF_Cluster_Based_Permutation_v2_ForPoster(TF_O_high_1) % retriaval
figure(122),clf, TF_Cluster_Based_Permutation_v2_ForPoster(TF_O_high_2) % reactivation  

% % Low
% figure(130),clf, TF_Cluster_Based_Permutation_v2_ForPoster(TF_O_low)
% [TF_O_low_1,TF_O_low_2] = SeparatePerCondition(TF_PO_low);
% figure(131),clf, TF_Cluster_Based_Permutation_v2_ForPoster(TF_O_low_1) % retriaval
% figure(132),clf, TF_Cluster_Based_Permutation_v2_ForPoster(TF_O_low_2) % reactivation  


