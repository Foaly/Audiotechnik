%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  Technische Universitaet Berlin
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
%%  Aufgabe A)

load('Pegel_Cello.mat');
SPL_min = min(pegel_i_cello_p(:));
SPL_norm = pegel_i_cello_p -SPL_min;


balloonplot(SPL_norm);

%%  Aufgabe B)

[A7_sr, A7] = read_spk('A7.SPK');
A7_abs = abs(A7);
freqs = linspace(0,24000,16385);
[value, ix] = min(abs(freqs - 1000));
A7_abs_norm = A7_abs./A7_abs(ix);
figure;
loglog(freqs,A7_f_abs);



