function [ model ] = svm_with_adaboost_train( training_data, training_labels )
% Trains an SVM classifier on the data with adaboost fs,
% and returns the model

%convert data tp proper formats
ada_data = training_data;
training_data = convert_to_vec(training_data);
for i=1:size(ada_data,1)
    ada_data{i} = arr_to_map(ada_data{i});
end

%run adaboost feature selection
ada_model = adaboost_train(ada_data, labels);
word_cell = adaboost_model_to_cell(ada_model);
words_used = array(word_cell);
training_data = training_data(:, words_used);

% set to radial kernel with default parameters and extra cache size (for now)
svm_params = '-m 3000 -q';
svm_model = svmtrain(training_labels, training_data, svm_params);

model = {svm_model, words_used};

end