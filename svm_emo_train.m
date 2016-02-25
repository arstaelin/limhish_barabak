function [ model ] = svm_emo_train( training_data, training_labels )
%SVM_TRAIN Trains an SVM classifier on the data, and returns the model

required_freq = 250;
required_freq2 = 10;

% set to radial kernel with default parameters and extra cache size (for now)
svm_params = '-m 3000 -q';

training_data = convert_to_vec(training_data);

%take only words that appear at least required_freq times:

load('posnegwords.mat');
freqs = sum(training_data);
words_used = find(freqs >= required_freq);
words_common = find(freqs >= required_freq2);
posneg = intersect(posneg, words_common);
words_used = sort(unique([words_used posneg]));
training_data = training_data(:,words_used);

svm_model = svmtrain(training_labels, training_data, svm_params);

model = {svm_model, words_used};

end
