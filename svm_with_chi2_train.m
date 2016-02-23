function [ model ] = svm_with_chi2_train( training_data, training_labels )
%SVM_TRAIN Trains an SVM classifier on the data with chi^2 fs,
%and returns the model

% set required freq and num of features
required_freq = 5;
feature_amount = 1000;

training_data = convert_to_vec(training_data);

%take only words that appear at least required_freq times:
freqs = sum(training_data);
words_used = find(freqs >= required_freq);
training_data = training_data(:,words_used);

%run chi^2 feature selection
[chi,~] = chi2feature(training_data, training_labels);
[~,I] = sort(chi,'descend');
important_features = I(1:feature_amount);
training_data = training_data(:,important_features);


% set to radial kernel with default parameters and extra cache size (for now)
svm_params = '-m 3000 -q';
svm_model = svmtrain(training_labels, training_data, svm_params);

model = {svm_model, words_used, important_features};

end

