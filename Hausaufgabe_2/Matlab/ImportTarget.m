function [X, offset] = ImportTarget(filename, scale_index, target_index, target)
    % import
    X = importdata(filename);
    X = X.data;

    % scale
    index = find(X(:, target_index) == target);
    offset = X(index, scale_index);
    X(:, scale_index) = X(:, scale_index) - offset;
end