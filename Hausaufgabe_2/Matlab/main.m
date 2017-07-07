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
% load and scale data
km120_0 = importdata('km120_0.txt');
km120_0 = km120_0.data;
km120_0 = Scale(km120_0, DBV, HZ, NORM_HZ);
sm58_0 = importdata('sm58_0.txt');
sm58_0 = sm58_0.data;
sm58_0 = Scale(sm58_0, DBV, HZ, NORM_HZ);

figure;
semilogx(km120_0(:, HZ), km120_0(:, DBV));
xlabel('Frequenz [Hz]')
ylabel('Schalldruckpegel [dBV]')
ylim([-30 5]);
print -depsc km120_0

figure;
semilogx(sm58_0(:, HZ), sm58_0(:, DBV));
xlabel('Frequenz [Hz]')
ylabel('Schalldruckpegel [dBV]')
ylim([-30 5]);
print -depsc sm58_0


% b)


% c)


% d)


% e)
