
function hash = hashstr(str)
% This function generates a hash value from a text string or array of strings
%
% inputs,
%   str : The text string, or array with text strings.
% outputs,
%   hash : The hash value, integer value between 0 and 2^32-1
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
str=double(str);
hash = zeros(size(str,1),1);
for i=1:size(str,2), 
    hash = mod(hash * 65599 + str(:,i), 2^32-1);
end

end

