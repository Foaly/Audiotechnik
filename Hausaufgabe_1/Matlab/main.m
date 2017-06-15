

[y,Fs] = audioread('Hausaufgabe_1_Impulsantwort.wav');

yq = y.^2;
sum1 = sum(yq);
R = sum1 - cumsum(yq);

EDC_norm = 10 * log10(R/sum1);

figure;
plot(EDC_norm);

T30 = find(EDC_norm < -30,1)/Fs;
T20 = find(EDC_norm < -20,1)/Fs;

%find first peak before maximum
[max1, maxIndex] = max(abs(y));
peakIndex = findchangepts(y(1:maxIndex-1), 'Statistic', 'linear')

T60_1 = 2*(T30-peakIndex/Fs);
T60_2 = 3*(T20-peakIndex/Fs);


figure;
plot(abs(y));

