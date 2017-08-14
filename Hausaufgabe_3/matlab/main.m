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
close all;
clear variables;

% read data
[A7_fs, A7] = read_spk('A7.SPK');

% normalize to 1000 Hz value
%freqs = linspace(0,24000,16385);
%[value, ix] = min(abs(freqs - 1000));
A7_abs = abs(A7);
A7_abs_norm = A7_abs./A7_abs(1000);

% convert to dB values
A7_db = 20*log10(A7_abs_norm);

% plot amplitude spectrum
figure;
semilogx(A7_db);
%xlim([20 300]);
grid on;
hold on;
xlabel('f [Hz]');
ylabel('normalisierte Amplitude');
title('Betragsfrequenzgang Adam A7');
% create impulse response
A7_ir = ifft(A7);
% create some parametric eqs and apply them
[b1, a1] = peq(A7_fs,150 , -7, 0.5)
[b2,a2] = peq(A7_fs, 20, 40, 1);
[b3,a3] = peq(A7_fs, 500, -20,20);
%A7_ir1 = filter(b1,a1, A7_ir);
%A7_ir1 = filter(b2,a2, A7_ir1);
 A7_ir1 = filter(b3,a3, A7_ir);
A7_1 = fft(A7_ir1);
% renormalize and replot
A7_1_abs = abs(A7_1);
A7_1_abs_norm = A7_1_abs./A7_1_abs(1000);
A7_1_db = 20*log10(A7_1_abs_norm);

semilogx(A7_1_db);
%xlim([20 300]);
hold off;

%%  Aufgabe C)
close all;
clear variables;
% given values 
ws = 2*pi*20;
Qts = 0.25;
Qtc = 1/sqrt(2);
Vas = 480;
% calculate wc (res.freq. of system)
wc = Qtc/Qts*ws;
% calculate G for 1 to 10000 Hz
freqs = linspace(2*pi*1,2*pi*10000,10000);
G_abs = abs(G(freqs,wc,Qtc));
% convert to dB values
G_dB = 20*log10(G_abs);
% plot G(f)

figure;
semilogx(freqs/(2*pi),G_dB);
axis([0 10000 -90 10]);
%title('Normaler Frequenzgang');
grid on;
ylabel('Amplitude in dB');
xlabel('Frequenz in Hz');
hold on;
% mark resonance frequency
fc = wc / (2*pi);
fcY = interp1(freqs/(2*pi), G_dB, fc);
stem(fc, fcY, '--ro', 'BaseValue', -90);
% mark -3 db cutoff
y = interp1(G_dB, freqs/(2*pi), -3);
stem(y, -3, '--r*');
%save plot
print('Normaler_Frequenzgang', '-depsc');

% calculate volume of box
Vb = 480/((wc/ws)^2-1);
% find Vb3 iteratively 
max3 = 0;
Vb3 = 480;
G_ref= max(G_abs);
while max3 <= 3 
    Vb3 = Vb3 - 1;
    Qtc3 = sqrt(Vas/Vb3 +1)*Qts;
    wc3 = Qtc3/Qts*ws;
    G_abs3 = abs(G(freqs,wc3,Qtc3));
    G_dB3 = 20*log10(G_abs3/G_ref);
    max3 = max(G_dB3);
end
Vb3
% find Vb1 iteratively 
max1 = 0;
Vb1 = 480;
while max1 <= 1
    Vb1 = Vb1 - 1;
    Qtc1 = sqrt(Vas/Vb1 +1)*Qts;
    wc1 = Qtc1/Qts*ws;
    G_abs1 = abs(G(freqs,wc1,Qtc1));
    G_dB1 = 20*log10(G_abs1/G_ref);
    max1 = max(G_dB1);
end
Vb1

figure;
semilogx(freqs/(2*pi),G_dB3);
axis([0 10000 -90 10])
%title('Frequenzgang bei 3 dB Überhöhung')
grid on;
ylabel('Amplitude in dB');
xlabel('Frequenz in Hz');
hold on;
% mark resonance frequency
fc3 = wc3 / (2*pi);
fc3Y = interp1(freqs/(2*pi), G_dB3, fc3);
stem(fc3, fc3Y, '--ro', 'BaseValue', -90);
% mark -3 db cutoff
y = interp1(G_dB3, freqs/(2*pi), -3);
stem(y, -3, '--r*');
%save plot
print('Frequenzgang_3dB', '-depsc');

figure;
semilogx(freqs/(2*pi),G_dB1);
axis([0 10000 -90 10])
%title('Frequenzgang bei 1 dB Überhöhung');
grid on;
ylabel('Amplitude in dB')
xlabel('Frequenz in Hz')
hold on;
% mark resonance frequency
fc1 = wc1 / (2*pi);
fc1Y = interp1(freqs/(2*pi), G_dB1, fc1);
stem(fc1, fc1Y, '--ro', 'BaseValue', -90);
% mark -3 db cutoff
y = interp1(G_dB1, freqs/(2*pi), -3);
stem(y, -3, '--r*');
%save plot
print('Frequenzgang_1dB', '-depsc');



