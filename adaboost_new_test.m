function [ label_vec ] = adaboost_new_test( model, data )
    label_vec = adaboost_new('apply', data, model);
end

