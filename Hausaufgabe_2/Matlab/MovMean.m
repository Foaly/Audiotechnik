function[Y] = MovMean(X, index, windowsize)
    Y = X;
    Y(:,3) = movmean(X(:, index), windowsize);
end