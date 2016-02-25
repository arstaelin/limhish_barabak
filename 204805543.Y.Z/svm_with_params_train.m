function [ model ] = svm_with_params_train( training_data, training_labels )
%SVM_TRAIN Trains an SVM classifier on the data, and returns the model.
% used pre-computes optimized paramaters

required_freq = 0.01;

% set to radial kernel with optimized paramaters
svm_params = '-m 3000 -q -g 0.015625 -c 5.656854';

training_data = convert_to_vec(training_data);

%take only words that appear at least required_freq times:
freqs = sum(training_data);
words_used = find(freqs >= (required_freq*size(training_data,1)));
training_data = training_data(:,words_used);

svm_model = svmtrain(training_labels, training_data, svm_params);

model = {svm_model, words_used};

end
