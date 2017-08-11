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
% third bands to octave bands
Lp_oct = zeros(91,181,7);
for i = 1:7
    Lp_oct(:,:,i) = 10*log10( 10.^(pegel_i_cello_p(:,:,i*3-2)./10)+ ...
                               10.^(pegel_i_cello_p(:,:,i*3-1)./10)+ ...
                               10.^(pegel_i_cello_p(:,:,i*3)./10)   );
end
% set minimum level value to 20 dB
Lp_min = min(Lp_oct(:));
Lp_change = 20 -Lp_min;
Lp_oct_norm = Lp_oct +Lp_change;
% do balloonplots
freqs = [125,250,500,1000,2000,4000,8000];
for i = 1:7
    balloonplot(Lp_oct_norm, freqs(i), i);
end

%%  Aufgabe B)

[A7_sr, A7] = read_spk('A7.SPK');
A7_abs = abs(A7);
freqs = linspace(0,24000,16385);
[value, ix] = min(abs(freqs - 1000));
A7_abs_norm = A7_abs./A7_abs(ix);
figure;
loglog(freqs,A7_abs_norm);



