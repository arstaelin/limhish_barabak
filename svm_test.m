function [ predictions ] = svm_test( model, data )
%SVM_TEST returns predictions of given SVM model on data

data = convert_to_vec(data);
[predictions] = svmpredict(zeros(size(data,1),1), data, model, '-q');

end