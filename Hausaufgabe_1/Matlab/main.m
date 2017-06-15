%% Aufgabe A)

[x,fs] = audioread('Hausaufgabe_1_Impulsantwort.wav');

% plot energy decay curve
figure;
EDC_norm = EDC(x);
plot(EDC_norm);


% find T20 & T30 time point
T30 = find(EDC_norm < -30,1)/fs;
T20 = find(EDC_norm < -20,1)/fs;

%find first peak before maximum
[max1, maxIndex] = max(abs(y));
peakIndex = findchangepts(y(1:maxIndex-1), 'Statistic', 'linear');

T60_1 = 2*(T30-peakIndex/fs);
T60_2 = 3*(T20-peakIndex/fs);


figure;
plot(abs(y));

%% Aufgabe B)

x_125  = oktavBand(y, 125, fs);
x_250  = oktavBand(y, 250, fs);
x_500  = oktavBand(y, 500, fs);
x_1000 = oktavBand(y, 100, fs);

T_125  = 3*((find(EDC(x_125) < -20,1)/fs)-peakIndex/fs);
T_250  = 3*((find(EDC(x_250) < -20,1)/fs)-peakIndex/fs);
T_500  = 3*((find(EDC(x_500) < -20,1)/fs)-peakIndex/fs);
T_1000 = 3*((find(EDC(x_1000) < -20,1)/fs)-peakIndex/fs);


BR = (T_125 + T_250) / (T_500 + T_1000);


%% Aufgabe C)

s_80 = 44100 / 1000 * 80;
