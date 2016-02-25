function classify_files( directory, classifier )
%classify_files Runs the given classifier on all files in given directory.
%   Doesn't run on folders, writes results to "predicted.txt".
    
    %Check if given directory path ends with '/'
    if (directory(end)~='\' && directory(end)~='/')
        directory = [directory, '/'];
    end
    outputID = fopen ('predicted.txt', 'w');
    file_list = dir(directory);
    list_size = size(file_list);
    for i = 1:list_size(1)
        curr_file = file_list(i);
        %If not a directory or output file, run the classifier on the file
        if (~curr_file.isdir && ~strcmp(curr_file.name, 'predicted.txt'))
            filename = [directory, curr_file.name];
            fprintf(outputID, '%s\t%u\n', curr_file.name, ...
                classifier(filename));
        end
    end
end

