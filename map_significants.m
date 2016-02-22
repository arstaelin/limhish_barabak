function [ labels, mat ] = map_significants( maps, classifications )
    %Recieves a cell-array of maps and a classification for each map.
    %Returns a matrix displaying the error of each weak-classifier
    %on each sample. Rows are samples, Cols are classifiers.
    %1 iff the classifier DOESN'T classify correctly
    num_maps = size(maps);
    num_maps = num_maps(1) * num_maps(2);
    significants = find_significants(maps);
    num_significants = size(significants);
    num_significants = num_significants(2);
    mat = sparse(num_maps, 2 * num_significants);
    labels = cell(1, 2 * num_significants);
    for i = 1:num_significants
        word = significants{i};
        labels{2*i-1} = [word, '_+1'];
        labels{2*i} = [word, '_-1'];
        expect1 = ones(num_maps, 1);
        expect2 = -1*ones(num_maps, 1);
        for j = 1:num_maps
            map = maps{j};
            if isKey(map, word)
                occurances = map(word);
                if occurances > 0
                    expect2(j) = 1;
                else
                    if occurances < 0
                        expect1(j) = 1;
                    end 
                end
            end
        end
        mat(:,2*i-1) = abs(expect1 - classifications)/2;
        mat(:,2*i) = abs(expect2 - classifications)/2;
    end
end

function [ significants ] = find_significants( maps )
    %Returns row cell-array of significant strings
    sign_factor = 0.07;

    histogram = containers.Map;
    for map_cell = maps
        map = map_cell{1};
        for word = keys(map)
           if isKey(histogram, word)
               histogram(word) = histogram(word) + 1;
           else    
               histogram(word) = 1;
           end
        end
    end
    num_maps = size(maps);
    num_maps = num_maps(1) * num_maps(2);
    significants = {};
    for word = keys(histogram)
        if histograms(word)/num_maps >= sign_factor
            significants = [ significants, {word}];
        end
    end
end
