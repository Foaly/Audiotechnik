function [T] = oktavBand (signal, fm, fs)
    nyquist = fs / 2;
    
    fu = fm / sqrt(2);
    fo = fu * 2;
    [b, a] = butter(3, [fu fo] / nyquist, 'bandpass');
    T = filter (b, a, signal);
end