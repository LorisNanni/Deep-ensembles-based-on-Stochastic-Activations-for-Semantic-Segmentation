we have used the segmentation approach available at https://github.com/LorisNanni/Deep-ensembles-based-on-Stochastic-Activation-Selection-for-Polyp-Segmentation

then we run 100 different DeepLabV3+ and store their output in:
ScoreCombinare{approach}{fold}; 
%approach 1:100, the different DeepLabV3+, fold=1:3, we run a 3-fold cross validation using training data
%each element of ScoreCombinare{approach}{fold} is a cell array with the mask obtained by the given DeepLabV3+, e.g
%ScoreCombinare{1}{1}{1} is the mask for the first image of the first fold obtained by the first DeepLabV3+ 

then we use SelectionDeepLab_Pudil.m for selectiong the best approaches, then
we train the selected DeepLabV3+ using the whole training set e tested them in the test set
