function [ vectors, labels ] = get_labeled_vectors( directory, vec_func )
%get_labeled_vectors Vectorizes files in a labeled folder using given func.
%   Assumes the folder is organized correctly - has two directories:
%   'pos' and 'neg'. Returns a cell array of the vectors, and label vector.

    if (directory(end)~='\' && directory(end)~='/')
        directory = [directory, '/'];
    end
    posdir = [directory, 'pos/'];
    negdir = [directory, 'neg/'];
    posvecs = folder_to_vectors(posdir, vec_func);
    negvecs = folder_to_vectors(negdir, vec_func);
    vectors = [posvecs; negvecs];
    labels = [ones(size(posvecs)); (-1)*ones(size(negvecs))];
end

