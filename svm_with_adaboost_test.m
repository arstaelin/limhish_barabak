function [ predictions ] = svm_with_adaboost_test( model, data )
%SVM_TEST returns predictions of given SVM model on data

svm_model = model{1};
words_used = model{2};

data = convert_to_vec(data);
data = data(:,words_used);
[predictions] = svmpredict(zeros(size(data,1),1), data, svm_model, '-q');