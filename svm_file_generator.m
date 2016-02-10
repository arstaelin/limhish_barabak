% writes vectors to file in svm format

disp('Reading data from files');
[data, labels] = get_labeled_vectors('.', @vector_basic);

disp('Writing to file')
fid = fopen('binary_svm_data', 'w+');
for i=1:size(data, 1)
    fprintf(fid, '%d', labels(i));
    last_word = 0;
    appearances = 0;
    for w=data{i}
        if (w ~= last_word)
            if (last_word ~= 0)
                fprintf(fid, ' %d:%d', last_word, appearances);
            end
            last_word = w;
            appearances = 1;
        else
            appearances = appearances + 1;
        end
    end
    fprintf(fid, ' %d:%d', last_word, appearances);
    fprintf(fid, ' \t\n');
end

fclose(fid);
disp('Done');