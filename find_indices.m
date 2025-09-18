function indices = find_indices(matrix, target_element)
    [rows, ~] = size(matrix);
    indices = cell(rows, 1);
    
    for i = 1:rows
        indices{i} = find(matrix(i, :) == target_element);
    end
end
