function [ model ] = svm_with_pca_train( training_data, training_labels )
%SVM_TRAIN Trains an SVM classifier on the data with chi^2 fs,
%and returns the model

% set required freq and num of features
required_freq = 25;
k = 200;

training_data = convert_to_vec(training_data);

%take only words that appear at least required_freq times:
freqs = sum(training_data);
words_used = find(freqs >= required_freq);
training_data = training_data(:,words_used);

%do pca:
[~,~,v] = svds(training_data,k);
% A = training_data;
% A2 = A'*A;
% n = size(training_data, 1);
% mns = sum(training_data)/size(training_data,1);
% [v,~] = eigs(@(x)(A2*x - mns'*sum(A*x) - (mns*x)*sum(A)' + n*(mns*x)*mns')...
%     ,size(training_data,2),k);
training_data = training_data*v;

% set to radial kernel with default parameters and extra cache size (for now)
svm_params = '-m 3000 -q';
svm_model = svmtrain(training_labels, training_data, svm_params);

model = {svm_model, words_used, v};

end