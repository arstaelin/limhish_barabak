function [ model ] = adaboost_train( data, labels )
    [~,model] = adaboost('train',data,labels,20);
end

