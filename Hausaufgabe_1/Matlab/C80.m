function [c80] = C80 (signal, fs)
    s_80 = 80 * fs / 1000; % 80ms in sample
    
    signal = signal.^2;
    
    num = sum(signal(1:s_80));
    denom = sum(signal(s_80:end));

    c80 = 10 * log10(num/denom);
end