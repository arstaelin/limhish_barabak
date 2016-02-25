function [ words ] = get_dict( data )
%GET_DICT Summary of this function goes here
%   Detailed explanation goes here

    words = [];
    for i = 1:size(data, 1)
        data{i} = unique(data{i});
        for w = data{i}
            if size(find(words == w),2) == 0
                words = [words w];
            end
        end
    end

    words = sort(words);
    
end

