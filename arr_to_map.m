function [ map ] = arr_to_map( arr )
%ARR_TO_MAP Summary of this function goes here
%   Detailed explanation goes here

    map = containers.Map(arr, ones(size(arr)));

end

