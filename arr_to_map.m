function [ map ] = arr_to_map( arr )
%ARR_TO_MAP Summary of this function goes here
%   Detailed explanation goes here
    
    str_cell = strsplit(num2str(arr),' ');
    map = containers.Map(str_cell, ones(size(arr)));

end

