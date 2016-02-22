function [ model ] = adaboost_train( data, labels )
    [~,model] = adaboost('train',data,labels,500);
end

