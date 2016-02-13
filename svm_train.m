function [ model ] = svm_train( training_data, training_labels )
%SVM_TRAIN Trains an SVM classifier on the data, and returns the model

% set to linear kernel with c=1 (for now)
svm_params = '-s 2 -t 0 -c 1 -q';
training_data = convert_to_vec(training_data);

model = svmtrain(training_labels, training_data, svm_params);

end
