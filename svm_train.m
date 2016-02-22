function [ model ] = svm_train( training_data, training_labels )
%SVM_TRAIN Trains an SVM classifier on the data, and returns the model

% set to radial kernel with default parameters and extra cache size (for now)
svm_params = '-s 2 -t 2 -m 1000 -q';
training_data = convert_to_vec(training_data);

model = svmtrain(training_labels, training_data, svm_params);

end
