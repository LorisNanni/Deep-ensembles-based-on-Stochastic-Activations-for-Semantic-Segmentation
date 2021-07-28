

% we have used the segmentation approach available at https://github.com/LorisNanni/Deep-ensembles-based-on-Stochastic-Activation-Selection-for-Polyp-Segmentation
%
% then we run 100 different DeepLabV3+ and store their output in:
% ScoreCombinare{approach}{fold};
% %approach 1:100, the different DeepLabV3+, fold=1:3, we run a 3-fold cross validation using training data
% %each element of ScoreCombinare{approach}{fold} is a cell array with the mask obtained by the given DeepLabV3+, e.g
% %ScoreCombinare{1}{1}{1} is the mask for the first image of the first fold obtained by the first DeepLabV3+
%
% then we use SelectionDeepLab_Pudil.m for selectiong the best approaches, then
% we train the selected DeepLabV3+ using the whole training set e tested them in the test set


%split training/test sets using original data
NumberFold=3;

for approach=1:length(ScoreCombinare)
    for fold=1:NumberFold
        SCtest{approach}{fold}{1}=ScoreCombinare{approach}{fold};
        SCtest{approach}{fold}{2}=trueMask{fold};%true mask, each element is a cell array with the true mask
        %e.g. trueMask{fold}{x} x-th true mask of the fold-th fold
    end
end


NCL=14 %number of selected DeepLabV3+ by Pudil based approach

%we use Pudil's approach
[R,perfS] = featselpSegmentation(SCtest,(NCL-1));

%to select the best layers selected using the training data
elenco=R(:,3);
Quali=unique(abs(elenco));%to store all selected features in the selection process, also the discarded
clear Tenere %to store only the best set
tmp=1;
for i=1:length(Quali)
    if sum(elenco==Quali(i))>sum(elenco==Quali(i)*-1)%a DeepLabV3+ is retained if it is added in the set one more time that it is discarded
        Tenere(tmp)= Quali(i);
        tmp=tmp+1;
    end
end
%now Tenere stores the id of the selected DeepLabV3+







