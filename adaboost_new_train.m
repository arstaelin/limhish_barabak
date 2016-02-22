function [ model ] = adaboost_new_train( data, labels )
    [~,model] = adaboost_new('train',data,labels,500);
end

