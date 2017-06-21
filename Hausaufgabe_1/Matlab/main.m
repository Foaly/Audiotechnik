%% Aufgabe A)

[x,fs] = audioread('Hausaufgabe_1_Impulsantwort.wav');

% cut signal to the first peak before absolute maximum
[max1, maxIndex] = max(abs(x));
peakIndex = findchangepts(x(1:maxIndex-1), 'Statistic', 'linear');
x = x(peakIndex:end);

% plot signal
figure;
plot(x);
xlabel('Samples');
ylabel('Amplitude');
print -depsc samples

% plot energy decay curve
EDC_norm = EDC(x);
figure;
plot(EDC_norm);
xlabel('Samples');
ylabel('dB');
print -depsc EDC_norm



% find T20 & T30 time point
T5 = find(EDC_norm < -5,1)/fs;

T25 = find(EDC_norm < -25,1)/fs;
T35 = find(EDC_norm < -35,1)/fs;

T20 = T25 - T5;
T30 = T35 - T5;

T20_old = find(EDC_norm < -20,1)/fs;
T30_old = find(EDC_norm < -30,1)/fs;

T60_1 = 2 * T30;
T60_2 = 3 * T20;

%% Aufgabe B)

% filter signal with a oktav bandpass
x_125  = oktavBand(x, 125, fs);
x_250  = oktavBand(x, 250, fs);
x_500  = oktavBand(x, 500, fs);
x_1000 = oktavBand(x, 1000, fs);

% find the reverb times for the filteres signals
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


% calculate bass ratio
BR = (T_125 + T_250) / (T_500 + T_1000);

%% Aufgabe C)

C80_125  = C80(x_125, fs);
C80_250  = C80(x_250, fs);
C80_500  = C80(x_500, fs);
C80_1000 = C80(x_1000, fs);


%% Aufgabe D)

[x2,x2_fs] = audioread('Hausaufgabe_1_Impulsantwort_binaural.wav');

% filter second signal with a oktav bandpass
x2_125  = oktavBand(x2, 125, x2_fs  );
x2_250  = oktavBand(x2, 250, x2_fs  );
x2_500  = oktavBand(x2, 500, x2_fs  );
x2_1000 = oktavBand(x2, 1000, x2_fs );

% IACC early for each band
IACC_early_125  = IACC(x2_125, x2_fs, 0, 80);
IACC_early_250  = IACC(x2_250, x2_fs, 0, 80);
IACC_early_500  = IACC(x2_500, x2_fs, 0, 80);
IACC_early_1000 = IACC(x2_1000, x2_fs, 0, 80);

% IACC late for each band
IACC_late_125  = IACC(x2_125, x2_fs, 80, 1000);
IACC_late_250  = IACC(x2_250, x2_fs, 80, 1000);
IACC_late_500  = IACC(x2_500, x2_fs, 80, 1000);
IACC_late_1000 = IACC(x2_1000, x2_fs, 80, 1000);


%% Aufgabe E)

V = 7 * 4 * 4;
S = (7 * 4 * 2 + 4 * 4) * 2;
ts = [T_125; T_250; T_500; T_1000];
as = Sabine(V, ts, S);


%% Aufgabe F)
% siehe DIN-18041 s.41

T_soll_musik = 0.45 * log10(V) + 0.07;
T_soll_sprache = 0.37 * log10(V) - 0.14;
T_soll_unterricht = 0.32 * log10(V) - 0.17;


%% Aufgabe G)
% siehe Möser s.76

lw = 85;
p = [4 2 0];
A = S * Sabine(V, T60_1, S);

res = 1/5;
X = 0:res:7;
Y = 0:res:4;
Z = 0:res:4;
L_ges = zeros(length(X), length(Y), length(Z));

for xi = 1:length(X)
    for yi = 1:length(Y)
        for zi = 1:length(Z)
            p2 = [X(xi) Y(yi) Z(zi)];
            dist = pdist([p; p2], 'euclidean');

            l_dir = lw - 20 * log(dist) - 8;
            l_dif = lw - 10 * log(A) + 6;
            l_ges = 10 * log10(10^(l_dir/10) + 10^(l_dif/10));
            L_ges(xi, yi, zi) = l_ges;
        end
    end
end

imagesc(X,Y,L_ges(:,:,1));
