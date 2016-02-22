function [estimateclasstotal, model] = adaboost_new (...
    mode, datafeatures, dataclass_or_model, itt)
% This function AdaBoost, consist of two parts a simple weak classifier and
% a boosting part:
% The boosting part calls the clasifier iteratively, after every classification
% step it changes the weights of miss-classified examples. This creates a
% cascade of "weak classifiers" which behaves like a "strong classifier"
%
%  Training mode:
%    [estimateclass,model]=adaboost('train',datafeatures,dataclass,itt)
%  Apply mode:
%    estimateclass=adaboost('apply',datafeatures,model)
% 
%  inputs/outputs:
%    datafeatures : An Array with size number_samples x number_features
%    dataclass : An array with the class off all examples, the class
%                 can be -1 or 1
%    itt : The number of training itterations
%    model : A struct with the cascade of weak-classifiers
%    estimateclass : The by the adaboost model classified data
%               
%  Function is written by D.Kroon University of Twente (August 2010)
%  Edited to match our needs (February 2016)
    
    switch(mode)
    case 'train'
        % Train the adaboost model
        
        % Set the data class 
        dataclass=dataclass_or_model(:);
        model=struct;
        
        %TODO: change datafeatures from cell column vector of row vectors
        %into matrix. That is: from this point we assume that datafeatures
        %is the sparse appearance-matrix.
        
        % Inverse every negatively-classified row
        data_length = length(dataclass);
        datafeatures = spdiags(dataclass, 0, data_length, data_length) ...
            * datafeatures;
        
        % Weight of training samples, first every sample is even important
        % (same weight)
        D=ones(length(dataclass),1)/length(dataclass);
        
        % This variable will contain the results of the single weak
        % classifiers weight by their alpha
        estimateclasssum=zeros(size(dataclass));
        
        timerVal = tic;
        % Do all model training itterations
        for t=1:itt
            % Find the best treshold to separate the data in two classes
            [estimateclass, err, h]= find_best(datafeatures, dataclass, D);

            % Weak classifier influence on total result is based on the current
            % classification error
            alpha=1/2 * log((1-err)/max(err,eps));
            
            % Store the model parameters
            model(t).alpha = alpha;
            model(t).key=h.key;
            model(t).factor=h.factor;
            
            % We update D so that wrongly classified samples will have more weight
            D = D.* exp(-model(t).alpha.*dataclass.*estimateclass); 
            D = D./sum(D);
            
            % Calculate the current error of the cascade of weak
            % classifiers
            estimateclasssum=estimateclasssum +estimateclass*model(t).alpha;
            estimateclasstotal=sign(estimateclasssum);
            model(t).error=sum(estimateclasstotal~=dataclass)/length(dataclass);
            if(model(t).error==0), break; end
        end
        toc(timerVal);
    case 'apply' 
        % Apply Model on the test data
        model=dataclass_or_model;
        
    
        % Add all results of the single weak classifiers weighted by their alpha 
        estimateclasssum=zeros(size(datafeatures,1),1);
        timerVal = tic;
        for t=1:length(model);
            curr_classific = datafeatures(:,model(t).key);
            curr_classific = (curr_classific * 2 - 1) * model(t).factor;
            estimateclasssum = estimateclasssum + model(t).alpha * ...
                curr_classific;
        end
        toc(timerVal);
        % If the total sum of all weak classifiers
        % is less than zero it is probablly class -1 otherwise class 1;
        estimateclasstotal=-sign(estimateclasssum);
        
    otherwise
        error('adaboost:inputs','unknown mode');
    end
end

function [ estimateclass, err, h ] = find_best( ...
    mat, classes, weights )
    %Finds the best weak classifier for the given weights.
    %Returns its estimates on the data, the error, the model
    
    h = struct;
    
    errors = mat' * weights;
    errors = errors + weights' * (classes - 1)/(-2);
    
    [mat_min, argmin] = min(errors);
    [mat_max, argmax] = max(errors);
    mat_max = 1 - mat_max;
    
    if mat_min < mat_max
        h.key = argmin;
        h.factor = 1;
        err = mat_min;
        estimateclass = abs(mat(:,argmin)) * 2 - 1;
    else
        h.key = argmax;
        h.factor = -1;
        err = mat_max;
        estimateclass = abs(mat(:,argmax)) * (-2) + 1;
    end
end
