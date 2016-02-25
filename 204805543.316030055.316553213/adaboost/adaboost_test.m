function [ label_vec ] = adaboost_test( model, data )
    label_vec = adaboost('apply', data, model);
end

