function [ model ] = adaboost_train( data, labels, itt )
    [~,model] = adaboost('train',data,labels,itt);
end

