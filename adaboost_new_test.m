function [ label_vec ] = adaboost_new_test( model, data )

    ada_model = model{1};
    important_words = model{2};
    data = data(:,important_words);
    
    label_vec = adaboost_new('apply', data, ada_model);
end

