function [scaled] = Scale(X, scale_index, target_index, target)
    index = find(X(:, target_index) == target);
    offset = X(index, scale_index);
    scaled = X;
    scaled(:, scale_index) = scaled(:, scale_index) - offset;
end