function [ sparse_vector ] = convert_to_vec( inp )
% converts a cell of arrays of hash values to a sparse matrix

row_ind = [];
col_ind = [];
vals = [];

for i=1:size(inp,1)
    unq = unique(inp{i});
    if unq(1) == 0
        unq = unq(2:size(unq,2));
    end
    row_ind = [row_ind i*ones(1,size(unq,2))];
    col_ind = [col_ind unq];
    vals = [vals ones(1,size(unq,2))];
end

sparse_vector = sparse(row_ind,col_ind,vals);

end
