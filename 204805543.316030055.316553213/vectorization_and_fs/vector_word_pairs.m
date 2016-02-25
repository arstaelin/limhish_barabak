function vector = vector_word_pairs(text)
% This function converts a text string into a vector. The vector is a sorted list of
% integers (hash values).

% split text:
delimiter = {' ','\f','\n','\r','\t','\v',',','.','?','!','''','"',...
    '_','-',':',';','(',')'};
sliced_text = strsplit(text, delimiter, 'CollapseDelimiters', true);
sliced_text = lower(sliced_text);

% add word pairs:
pairs = cell(1, size(sliced_text, 2)-1);
for i=1:size(pairs, 2)
    pairs{i} = [sliced_text{i},'-',sliced_text{i+1}];
end
sliced_text = [sliced_text, pairs];

% hash:
vector = hashstr(sliced_text);
vector = sort(vector);

end
