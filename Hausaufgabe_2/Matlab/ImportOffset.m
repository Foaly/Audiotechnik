function [X] = ImportOffset(filename, offset_index, offset)
    % import
    X = importdata(filename);
    X = X.data;

    % scale
    X(:, offset_index) = X(:, offset_index) - offset;
end