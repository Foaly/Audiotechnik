function [edc] = EDC(signal)
    % square signal
    xq = signal.^2;

    % discretize Schröder integral
    R = sum(xq) - cumsum(xq);

    % normalized energy decay curve
    edc = 10 * log10(R/sum(xq));
end