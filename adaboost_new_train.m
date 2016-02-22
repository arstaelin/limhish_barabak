function [ model ] = adaboost_new_train( data, labels )

    %use only some of the words:
    frqs = sum(data);
    important_words = find(frqs >= 150);
    data = data(:,important_words);
    
    [~,ada_model] = adaboost_new('train',data,labels,500);
    
    model = {ada_model, important_words};
end

