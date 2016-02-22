function [estimateclasstotal, model] = adaboost (...
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
        
        % Weight of training samples, first every sample is even important
        % (same weight)
        D=ones(length(dataclass),1)/length(dataclass);
        
        % This variable will contain the results of the single weak
        % classifiers weight by their alpha
        estimateclasssum=zeros(size(dataclass));

        [labels, mat] = map_significants( datafeatures, dataclass);
        
        % Do all model training itterations
        for t=1:itt
            % Find the best treshold to separate the data in two classes
            [estimateclass, err, h , classmult] = find_best( ...
    labels, mat, classes, weights);

            % Weak classifier influence on total result is based on the current
            % classification error
            alpha=1/2 * log((1-err)/max(err,eps));
            
            % Store the model parameters
            model(t).alpha = alpha;
            model(t).key=h.key;
            model(t).factor=h.factor;

            % We update D so that wrongly classified samples will have more weight
            D = D.* exp(-model(t).alpha.*dataclass.*estimateclass); %TODO: last multipication is classmult
            D = D./sum(D);
            
            % Calculate the current error of the cascade of weak
            % classifiers
            estimateclasssum=estimateclasssum +estimateclass*model(t).alpha;
            estimateclasstotal=sign(estimateclasssum);
            model(t).error=sum(estimateclasstotal~=dataclass)/length(dataclass);
            if(model(t).error==0), break; end
        end
        
    case 'apply' 
        % Apply Model on the test data
        model=dataclass_or_model;
        
    
        % Add all results of the single weak classifiers weighted by their alpha 
        estimateclasssum=zeros(size(datafeatures,1),1);
        for t=1:length(model);
            estimateclasssum = estimateclasssum + model(t).alpha * ...
                weak_classify_multi(model(t), datafeatures);
        end
        % If the total sum of all weak classifiers
        % is less than zero it is probablly class -1 otherwise class 1;
        estimateclasstotal=sign(estimateclasssum);
        
    otherwise
        error('adaboost:inputs','unknown mode');
    end
end

function [ estimateclass, err, h , classmult] = find_best( ...
    labels, mat, classes, weights )
    %Finds the best weak classifier for the given weights.
    %Returns its estimates on the data, the error, the model
    
    h = struct;
    errors = (weights * mat)';
    [mat_min, argmin] = min(errors);
    [mat_max, argmax] = max(errors);
    mat_max = 1 - mat_max;
    
    if mat_min < mat_max
        h.key = labels{argmin};
        h.factor = 1;
        err = mat_min;
        col = mat(:,argmin);
        classmult = (-2 * col) + 1; % is a column
        estimateclass = classes;
        estimateclass(col) = estimateclass(col)*-1; % is a column
    else
        h.key = labels{argmax};
        h.factor = -1;
        err = mat_max;
        col = mat(:,argmax);
        classmult = (2 * col) - 1; % is a column
        estimateclass = classes;
        estimateclass(col) = estimateclass(col)*-1; % is a column
        estimateclass = estimateclass * -1;
    end
end

function [result] = weak_classify_multi (h, maps) 
    %Applies the model on multiple maps in a cell array
    key_parts = strsplit(h.key, '_', 'CollapseDelimiters', true);
    num_maps = size(maps);
    num_maps = num_maps(1) * num_maps(2);
    result = zeros(num_maps, 1);
    for i = 1:num_maps
        result(i) = weak_classify(h, maps{i}, key_parts(1), key_parts(2));
    end
end

function [ result ] = weak_classify (h, map, part1, part2)
    %Applies the model on a single map
    if strcmp('+1', part2)
        if isKey(map, part1)
            result = (map(part1) >= 0) * 2 - 1;
        else
            result = 1;
        end
    else
        if isKey(map, part1)
            result = (map(part1) > 0) * 2 - 1;
        else
            result = -1;
        end
    end
    result = result * h.factor;
end