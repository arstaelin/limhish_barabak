function [ accuracy ] = cross_val( data, labels, ftrain, ftest)
%CROSS_VAL recieves as input the data, a training function, a testing
% function, and returns accuracy.
%
%   input:
%   data - an nX1 cell of vectors
%   labels - an nX1 vector of labels
%   ftrain - a function handle that recieves (data,labels) as arguments
%       and returns a model for predictions.
%   ftest - a function handle that recieves (model, data) and returns a
%       a vector of labels.
%
%   output:
%   accuracy - n-fold cross-validation accuracy of ftrain and ftest on
%       data

n_fold = 5;

% shuffle data:
I = randperm(size(labels,1));
labels = labels(I);
data = data(I,:);

error = 0;

% do cross validation:
for i=1:n_fold
    lower = int32((size(data,1)*(i-1))/n_fold);
    upper = int32((size(data,1)*(i))/n_fold) + 1;
    training_data = data([1:lower ,upper:size(data,1)],:);
    training_labels = labels([1:lower ,upper:size(labels,1)],:);
    testing_data = data(lower+1:upper-1,:);
    testing_labels = labels(lower+1:upper-1);
    
    % train and test:
    m = ftrain(training_data, training_labels);
    predictions = ftest(m, testing_data);
    error = error + sum(predictions ~= testing_labels);
    
    disp(['finished ',num2str(i),' iteration'])
end

accuracy = error/size(labels,1);

end

