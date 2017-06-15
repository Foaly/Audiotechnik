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
[max1, maxIndex] = max(abs(x));
peakIndex = findchangepts(x(1:maxIndex-1), 'Statistic', 'linear');

T60_1 = 2*(T30-peakIndex/fs);
T60_2 = 3*(T20-peakIndex/fs);


figure;
plot(abs(x));

%% Aufgabe B)

x_125  = oktavBand(x, 125, fs);
x_250  = oktavBand(x, 250, fs);
x_500  = oktavBand(x, 500, fs);
x_1000 = oktavBand(x, 1000, fs);

T_125  = 3*((find(EDC(x_125) < -20,1)/fs)-peakIndex/fs);
T_250  = 3*((find(EDC(x_250) < -20,1)/fs)-peakIndex/fs);
T_500  = 3*((find(EDC(x_500) < -20,1)/fs)-peakIndex/fs);
T_1000 = 3*((find(EDC(x_1000) < -20,1)/fs)-peakIndex/fs);


BR = (T_125 + T_250) / (T_500 + T_1000);


%% Aufgabe C)

C80_125  = C80(x_125, fs);
C80_250  = C80(x_250, fs);
C80_500  = C80(x_500, fs);
C80_1000 = C80(x_1000, fs);
