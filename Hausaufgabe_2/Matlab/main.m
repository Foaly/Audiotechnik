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
km120_0 = ImportScaled('km120_0.txt', DBV, HZ, NORM_HZ);
sm58_0 = ImportScaled('sm58_0.txt', DBV, HZ, NORM_HZ);


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


%% b)
km120_0_mvavg = mov_avg(km120_0, 3);
sm58_0_mvavg = mov_avg(sm58_0, 3);

% c)


% d)


% e)
