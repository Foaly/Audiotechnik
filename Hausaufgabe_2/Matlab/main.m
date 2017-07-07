%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Technische Universität Berlin
%%  Fachgebiet Audiokommunikation
%%  Audiotechnik - Zweite Hausaufgabe
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 
%%  Anyere Bendrien 382004
%%  anyere.bendrien@campus.tu-berlin.de
%%  
%%  Jason Horn 382104
%%  j.horn@campus.tu-berlin.de
%%
%%  Maximilian Wagenbach 382110
%%  m.wagenbach@campus.tu-berlin.de
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear variables;
clc;


%%%%%%%%%%%%%%%
%%  Aufgabe 1
%%%%%%%%%%%%%%%

BIN = 1; HZ = 2; DBV = 3;
NORM_HZ = 1000;


%% a)
[km120_0, km120_offset] = ImportTarget('km120_0.txt', DBV, HZ, NORM_HZ);
[sm58_0, sm58_offset] = ImportTarget('sm58_0.txt', DBV, HZ, NORM_HZ);

figure;
semilogx(km120_0(:, HZ), km120_0(:, DBV));
xlabel('Frequenz [Hz]');
ylabel('Schalldruckpegel [dBV]');
xlim([45 22500]);
ylim([-30 5]);
print -depsc km120_0

figure;
semilogx(sm58_0(:, HZ), sm58_0(:, DBV));
xlabel('Frequenz [Hz]');
ylabel('Schalldruckpegel [dBV]');
xlim([45 22500]);
ylim([-30 5]);
print -depsc sm58_0


%% b)
km120_0_movmean = MovMean(km120_0, DBV, 3);
sm58_0_movmean = MovMean(sm58_0, DBV, 3);

figure;
semilogx(sm58_0_movmean(:, HZ), sm58_0_movmean(:, DBV));
hold on
semilogx(sm58_0(:, HZ), sm58_0(:, DBV));
hold off
legend('Geglättet', 'Normal', 'Location', 'northwest');
xlabel('Frequenz [Hz]');
ylabel('Schalldruckpegel [dBV]');
xlim([45 22500]);
ylim([-30 5]);
print -depsc sm58_0_movmean

figure;
semilogx(km120_0_movmean(:, HZ), km120_0_movmean(:, DBV));
hold on
semilogx(km120_0(:, HZ), km120_0(:, DBV));
hold off
legend('Geglättet', 'Normal', 'Location', 'northwest');
xlabel('Frequenz [Hz]');
ylabel('Schalldruckpegel [dBV]');
xlim([45 22500]);
ylim([-30 5]);
print -depsc km120_0_movmean

%% c)
km120_90 = ImportOffset('km120_90.txt', DBV, km120_offset);
km120_180 = ImportOffset('km120_180.txt', DBV, km120_offset);
sm58_90 = ImportOffset('sm58_90.txt', DBV, sm58_offset);
sm58_180 = ImportOffset('sm58_180.txt', DBV, sm58_offset);
km120_90_movmean = MovMean(km120_90, DBV, 3);
km120_180_movmean = MovMean(km120_180, DBV, 3);
sm58_90_movmean = MovMean(sm58_90, DBV, 3);
sm58_180_movmean = MovMean(sm58_180, DBV, 3);

%%
figure;
semilogx(km120_0_movmean(:, HZ), km120_0_movmean(:, DBV));
hold on
semilogx(km120_90_movmean(:, HZ), km120_90_movmean(:, DBV));
semilogx(km120_180_movmean(:, HZ), km120_180_movmean(:, DBV));
hold off
legend('    0°','  90°', '120°','Location', 'northwest');
xlabel('Frequenz [Hz]')
ylabel('Schalldruckpegel [dBV]')
xlim([45 22500]);
ylim([-45 5])
print -depsc km120_all

figure;
semilogx(sm58_0_movmean(:, HZ), sm58_0_movmean(:, DBV));
hold on
semilogx(sm58_90_movmean(:, HZ), sm58_90_movmean(:, DBV));
semilogx(sm58_180_movmean(:, HZ), sm58_180_movmean(:, DBV));
hold off
legend('    0°','  90°', '120°','Location', 'northwest');
xlabel('Frequenz [Hz]')
ylabel('Schalldruckpegel [dBV]')
xlim([45 22500]);
ylim([-45 5])
print -depsc sm58_all


%% d)
KM184 = xlsread('10Grad+KM184.xls','A4:AL138');


% e)
