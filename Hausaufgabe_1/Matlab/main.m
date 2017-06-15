%% Aufgabe A

[x,Fs] = audioread('Hausaufgabe_1_Impulsantwort.wav');

% plot energy decay curve
figure;
plot(EDC(x));


% find T20 & T30 time point
T30 = find(EDC_norm < -30,1)/Fs;
T20 = find(EDC_norm < -20,1)/Fs;

%find first peak before maximum
[max1, maxIndex] = max(abs(y));
peakIndex = findchangepts(y(1:maxIndex-1), 'Statistic', 'linear');

T60_1 = 2*(T30-peakIndex/Fs);
T60_2 = 3*(T20-peakIndex/Fs);


figure;
plot(abs(y));

%% B

x_125  = oktavBand(y, 125, Fs);
x_250  = oktavBand(y, 250, Fs);
x_500  = oktavBand(y, 500, Fs);
x_1000 = oktavBand(y, 100, Fs);

T_125  = 3*((find(EDC(x_125) < -20,1)/Fs)-peakIndex/Fs);
T_250  = 3*((find(EDC(x_250) < -20,1)/Fs)-peakIndex/Fs);
T_500  = 3*((find(EDC(x_500) < -20,1)/Fs)-peakIndex/Fs);
T_1000 = 3*((find(EDC(x_1000) < -20,1)/Fs)-peakIndex/Fs);


BR = (T_125 + T_250) / (T_500 + T_1000);
