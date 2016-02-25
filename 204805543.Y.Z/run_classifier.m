function run_classifier( directory, model, vectorfunc, classfunc )
%Runs the given classifier function on vectors made from the given dir.
    if (directory(end)~='\' && directory(end)~='/')
        directory = [directory, '/'];
    end
    file_list = dir(directory);
    list_size = size(file_list);
    vectors = cell(list_size(1)-2, 1); %-2 because of the folders . and ..
    file_names = cell(list_size(1)-2, 1); 
    curr_cell = 1;
    for i = 1:list_size(1)
        curr_file = file_list(i);
        %If not a directory or output file
        if (~curr_file.isdir)
            filename = [directory, curr_file.name];
            file_names{curr_cell,1} = curr_file.name;
            file_content = fileread(filename);
            vectors{curr_cell, 1} = vectorfunc(file_content);
            curr_cell = curr_cell + 1;
        end
    end
    %Trim the output cell array, in case there were folders in the folder.
    vectors = vectors(1:curr_cell-1, 1); 
    file_names = file_names(1:curr_cell-1, 1); 
   
    num_vectors = len(vectors);
    
    %Run the classifier on the vectors and fix -1 to 0
    classes = classfunc(model, vectors);
    classes(classes == -1) = 0;
    
    %Output results to 'predicted.txt'
    fileID = fopen('predicted.txt', 'w');
    for i = 1:num_vectors
       fprintf(fileID, [file_names{i}, '\t', int2str(classes(i))]);
    end
    fclose(fileID);
end

