
function [hash] = hashstr(str)
% This function generates an array of hash values from a cell of strings
%
% inputs,
%   str : The text string cell.
% outputs,
%   hash : The hash value array, integer value between 0 and 2^32-1
%
% sdbm
%  this algorithm was created for sdbm (a public-domain reimplementation of
%  ndbm) database library. it was found to do well in scrambling bits, 
%  causing better distribution of the keys and fewer splits. it also happens
%  to be a good general hashing function with good distribution.
%
% Taken from: http://www.mathworks.com/matlabcentral/fileexchange/27940-string2hash/
% content/string2hash.m


% From string to double array
hash = zeros(size(str));
for i=1:size(str,2)
    for c=str{1,i}
        hash(i) = mod(hash(i) * 65599 + double(c), 2^32-1);
    end
end

end

