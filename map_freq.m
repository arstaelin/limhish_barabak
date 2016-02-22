function map = map_freq(text)
%This function converts a text string into a histogram.
%Negative words in a sentence all words in it be counted as negative

sentence_del = {'.', ',', ':', ';', '?', '!'};

sliced_text = strsplit(text, sentence_del, 'CollapseDelimiters', true);
sliced_text = lower(sliced_text);
sliced_text = regexprep(sliced_text,'[^A-Za-z0-9 ]', '');
map = containers.Map;
    for sentence_cell=sliced_text
        sentence = sentence_cell{1};
        update_map(map, sentence);
    end
end

function update_map(map, text)
    delimiter = {' ','\f','\n','\r','\t','\v',',','.','?','!','''','"',...
        '_','-',':',';','(',')'};
    sliced_text = strsplit(text, delimiter, 'CollapseDelimiters', true);
    sliced_text = lower(sliced_text);
    negative = {'no','not','never','none','nobody','dont', ...
        'doesnt','wont','havent','hasnt','hadnt','neither','nor', ...
        'nothing','nowhere','hardly','rarely','scarcely','seldom'};
    factor = 1;
    if ~isempty(intersect(sliced_text, negative))
        factor = -1;
    end
    for word_cell=sliced_text
        word = word_cell{1};
        if ~isempty(word)
            if isKey(map, word)
                map(word) = map(word) + factor;
            else
                map(word) = factor;
            end
        end
    end
end