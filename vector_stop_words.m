function [ vector ] = vector_stop_words( text )
%VECTOR_STOP_WORDS vectorizes the text, while also removing stop words.

delimiter = {' ','\f','\n','\r','\t','\v',',','.','?','!','''','"',...
    '_','-',':',';','(',')'};
sliced_text = strsplit(text, delimiter, 'CollapseDelimiters', true);
sliced_text = lower(sliced_text);

%remove stopwords:
fid = fopen('english.stop');
stopwords = textscan(fid, '%s');
stopwords = stopwords{1,1};
fclose(fid);

for i=1:size(sliced_text)
    if isStopWord(sliced_text{i},stopwords)
        sliced_text{i} = '';
    end
end

vector = hashstr(sliced_text);
vector = sort(vector);

end

