function [IACC] = IACC(h, fs, t1, t2)

% convert ts from ms into samples
s1ms = ceil(fs/1000);
s1 = floor(t1*fs/1000)+1;
s2 = floor(t2*fs/1000)+1;
len = s2 - s1;

% get samples of interest and split channels
l = h(s1:s2, 1);
r = h(s1:s2, 2);

% rms value
rms = sqrt(sum(l.^2) * sum(r.^2));

% pad right channel for tau
r_pad = [zeros(s1ms,1); r; zeros(s1ms,1)];

for t = 1:(2*s1ms)
    p = sum(l.*r_pad(t:t+len));
    IACF(t) = p / rms;
end

IACC = max(abs(IACF));

end