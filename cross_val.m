function [ accuracy ] = cross_val( data, labels, ftrain, ftest, vector)
%CROSS_VAL recieves as input the data, a training function, a testing
% function and a function to data to a vector, and returns accuracy.

% vectorize data:
for i=1:size(data, 1)
    data{i} = vector(data{i});
end

% shuffle data:
I = randperm(size(labels,1));
labels = labels(I);
data = data(I);

error = 0;

% do cross validation:
for i=1:10
    lower = int32((size(data,1)*(i-1))/10);
    upper = int32((size(data,1)*(i))/10) + 1;
    training_data = data([1:lower ,upper:size(data,1)],:);
    training_labels = labels([1:lower ,upper:size(labels,1)],:);
    testing_data = data(lower+1:upper-1);
    testing_labels = labels(lower+1:upper-1);
    
    % train and test:
    m = ftrain(training_data, training_labels);
    predictions = ftest(m, testing_data);
    error = error + sum(predictions ~= testing_labels);
end

accuracy = error/size(labels,1);

end

