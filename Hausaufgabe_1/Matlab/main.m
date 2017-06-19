%% Aufgabe A)

[x,fs] = audioread('Hausaufgabe_1_Impulsantwort.wav');

% plot energy decay curve
figure;
EDC_norm = EDC(x);
plot(EDC_norm);


% find T20 & T30 time point
T5 = find(EDC_norm < -5,1)/fs;

T25 = find(EDC_norm < -25,1)/fs;
T35 = find(EDC_norm < -35,1)/fs;

T20 = T25 - T5;
T30 = T35 - T5;

T20_old = find(EDC_norm < -20,1)/fs;
T30_old = find(EDC_norm < -30,1)/fs;

%find first peak before maximum
%[max1, maxIndex] = max(abs(x));
%peakIndex = findchangepts(x(1:maxIndex-1), 'Statistic', 'linear');
%beginOffset = peakIndex/fs;

T60_1 = 2 * T30;
T60_2 = 3 * T20;


figure;
plot(abs(x));

%% Aufgabe B)

x_125  = oktavBand(x, 125, fs);
x_250  = oktavBand(x, 250, fs);
x_500  = oktavBand(x, 500, fs);
x_1000 = oktavBand(x, 1000, fs);

T_125_5  = find(EDC(x_125) < -5,1)/fs;
T_125_25 = find(EDC(x_125) < -25,1)/fs;
T_125    = 3*(T_125_25 - T_125_5);

T_250_5  = find(EDC(x_250) < -5,1)/fs;
T_250_25 = find(EDC(x_250) < -25,1)/fs;
T_250    = 3*(T_250_25 - T_250_5);

T_500_5  = find(EDC(x_500) < -5,1)/fs;
T_500_25 = find(EDC(x_500) < -25,1)/fs;
T_500    = 3*(T_500_25 - T_500_5);

T_1000_5  = find(EDC(x_1000) < -5,1)/fs;
T_1000_25 = find(EDC(x_1000) < -25,1)/fs;
T_1000    = 3*(T_1000_25 - T_1000_5);


BR = (T_125 + T_250) / (T_500 + T_1000);


%% Aufgabe C)

C80_125  = C80(x_125, fs);
C80_250  = C80(x_250, fs);
C80_500  = C80(x_500, fs);
C80_1000 = C80(x_1000, fs);
