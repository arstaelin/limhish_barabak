function [ vectors ] = folder_to_vectors( directory, vec_func )
%folder_to_vectors Vectorizes files in the given folder using given func.
%   Returns a cell array of the vectors.
    
    if (directory(end)~='\' && directory(end)~='/')
        directory = [directory, '/'];
    end
    file_list = dir(directory);
    list_size = size(file_list);
    vectors = cell(list_size(1)-2, 1); %-2 because of the folders . and ..
    curr_cell = 1;
    for i = 1:list_size(1)
        curr_file = file_list(i);
        %If not a directory or output file
        if (~curr_file.isdir)
            filename = [directory, curr_file.name];
            %fileID = fopen(filename, 'r');
            %file_content = fscanf(fileID, '%s');
            file_content = fileread(filename);
            %fclose(fileID);
            vectors{curr_cell, 1} = vec_func(file_content);
            curr_cell = curr_cell + 1;
        end
    end
    %Trim the output cell array, in case there were folders in the folder.
    vectors = vectors(1:curr_cell-1, 1); 
end

