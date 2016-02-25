function [ prediction ] = nb_test( model, data )
% naive bayes classifier

nb_model = model{1};
words = model{2};

data = convert_to_vec(data);
data = data(:,words);

prediction = predict(nb_model, data);

end

