function [ predictions ] = svm_with_pca_test( model, data )
%SVM_TEST returns predictions of given SVM model on data

svm_model = model{1};
words_used = model{2};
v = model{3};

data = convert_to_vec(data);
data = data(:,words_used);
data = data*v;
[predictions] = svmpredict(zeros(size(data,1),1), data, svm_model, '-q');

end

