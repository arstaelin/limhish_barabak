function [ vector ] = vector_stem_and_stop( text )
%VECTOR_STEM_AND_STOP vectorizes the text, while also stemming and
%   removing stop words.

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
    if(size(sliced_text{i})>=2)
        sliced_text{i} = porterStemmer(sliced_text{i});
    end
    if isStopWord(sliced_text{i},stopwords)
        sliced_text{i} = '';
    end
end

vector = hashstr(sliced_text);
vector = sort(vector);

end
