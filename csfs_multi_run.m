function [optW, opt_threshold_value, opt_macro_F] =...
    csfs_multi_run(Xtr, Ytr, Xva, Yva,...
    vecTopFeaNum,  lambda, FmValues, thresholds, nIteration)
% outer loop with value of fmeasure t
% Xtrva: d*n training data matrix, each column is a data point
% Ytrva: n*c label matrix
% Xtrva = Xtr + Xva;
% Ytrva = Ytr + Yva;


opt_macro_F = 0;
opt_threshold_value = 0;
optW = [];
optT = 0;
beta = 1;

vaRandSeeds = [123, 234, 345, 456, 567, 678, 789, 890];

%--------------------------------------------------------------------------------------
% parallel subproblems for differnt F-measure value t
%--------------------------------------------------------------------------------------
fprintf('\nCSFS multiple run computing, lambda = %f,...\n', lambda);
for iFmvalues = 1 : length(FmValues)
    
    t = FmValues(iFmvalues); % pick one Fmeasure value
    V =  gen_cost_matrix(Ytr, t, beta ); %cost matrix
    
    W = csfs_l21r21(Xtr, Ytr, V, lambda, nIteration);
    
    %--------------------------------------------------------------------------------------
    % Evaluation
    %--------------------------------------------------------------------------------------
    % Calculate Macro_F_Measure or select some features
    
    [~, sorted_idx] = sort(sum(W.*W , 2), 'descend');
    feature_idx = sorted_idx(1 : vecTopFeaNum);
    svm_X = Xva( feature_idx, :);
        
    
    
    for iClassNum = 1: size(Yva, 2) % each label
        %for F-measure
        single_label_Ytest = Yva( : , iClassNum);               
        all_classes_accuracies(iClassNum) =...
            svmtrain(single_label_Ytest,svm_X', '-t 0 -v 5 -q');
        
    end
        
    all_classes_f1scores = all_classes_accuracies;
    cur_macro_F = mean(all_classes_f1scores);
    if cur_macro_F >= opt_macro_F
        opt_macro_F = cur_macro_F;
        optW = W;
        optT = t;
    end
    
end
fprintf('--------------------------------------------------\n');
fprintf('choose Fmeasure value %f .\n', optT);
fprintf('--------------------------------------------------\n');
end
