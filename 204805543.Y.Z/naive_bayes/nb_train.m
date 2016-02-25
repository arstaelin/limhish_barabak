function [ model ] = nb_train( data, labels )
% naive bayes classifier

req_freq = 0.01;

data = convert_to_vec(data);
words = sum(data)>=(req_freq*size(data,1));
data = data(:,words);

nb_model = fitNaiveBayes(data,labels);
model = {nb_model, words, features};

end