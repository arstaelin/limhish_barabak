function [ sparse_vector ] = convert_to_vec( inp )
% converts a cell of arrays of hash values to a sparse matrix

sparse_vector = sparse(size(inp, 1), 2^30);
for i=1:size(inp, 1)
    for w=inp{i}
        if(w~=0)
            sparse_vector(i,w) = sparse_vector(i,w)+1;
        end
    end
end
end
