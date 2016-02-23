function [ output ] = adaboost_model_to_cell( model, unique )
%adaboost_model_to_cell Takes a model given from an adaboost train
%   And returns a cell array containing all words used in classification.
%   If unique = 0, returns as is. If unique = 1, returns unique words only

    len = length(model);
    output = cell(len, 1);
    for i = 1:len
        splat = strsplit(model(i).key, '_');
        output(i) = splat(1);
    end
    
    if unique == 1
        output = unique(output, 'stable');
    end
end    

