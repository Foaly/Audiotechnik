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
%print -depsc km120_0

figure;
semilogx(sm58_0(:, HZ), sm58_0(:, DBV));
xlabel('Frequenz [Hz]');
ylabel('Schalldruckpegel [dBV]');
xlim([45 22500]);
ylim([-30 5]);
%print -depsc sm58_0


%% b)
km120_0_movmean = MovMean(km120_0, DBV, 3);
sm58_0_movmean = MovMean(sm58_0, DBV, 3);

figure;
semilogx(sm58_0_movmean(:, HZ), sm58_0_movmean(:, DBV));
hold on
semilogx(sm58_0(:, HZ), sm58_0(:, DBV));
hold off
legend('Gegl√§ttet', 'Normal', 'Location', 'northwest');
xlabel('Frequenz [Hz]');
ylabel('Schalldruckpegel [dBV]');
xlim([45 22500]);
ylim([-30 5]);
%print -depsc sm58_0_movmean

figure;
semilogx(km120_0_movmean(:, HZ), km120_0_movmean(:, DBV));
hold on
semilogx(km120_0(:, HZ), km120_0(:, DBV));
hold off
legend('Gegl√§ttet', 'Normal', 'Location', 'northwest');
xlabel('Frequenz [Hz]');
ylabel('Schalldruckpegel [dBV]');
xlim([45 22500]);
ylim([-30 5]);
%print -depsc km120_0_movmean

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
legend('    0∞','  90∞', '180∞','Location', 'northwest');
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
legend('    0∞','  90∞', '180∞','Location', 'northwest');
xlabel('Frequenz [Hz]')
ylabel('Schalldruckpegel [dBV]')
xlim([45 22500]);
ylim([-45 5])
print -depsc sm58_all


%% d)
% read .xls file
KM184 = xlsread('10Grad+KM184.xls','A4:AL138');
% prepare polar plot
theta = 0:5/360*2*pi:2*pi;
KM184_flipped = fliplr(KM184);
rho = [ KM184(:,2:38) KM184_flipped(:,2:37)];
% polar plots separetely
index = zeros();
f = 125;
i=1;
while f <=16000
    figure;
    [value, index(i)] = min(abs(KM184(:,1)-f));
    mmpolar(theta, rho(index(i),:)-rho(index(i),1), ...
    'Style','compass', 'RLimit' , [1 -25], 'RTickAngle', 0.001, ...
    'RTickLabel', cellstr(['-20'; '-15';'-10'; ' -5';'  0']), ...
    'RTickValue',[-20 -15 -10 -5 0] );
    print(['KM184_' num2str(f) 'Hz'],'-depsc')
    f = f*2;
    i = i+1;
end
% polar plot all in one
figure;
mmpolar(theta, rho(index(1),:)-rho(index(1),1), '-r', ...
        theta, rho(index(2),:)-rho(index(2),1), '-g', ...
        theta, rho(index(3),:)-rho(index(3),1), '-b', ...
        theta, rho(index(4),:)-rho(index(4),1), '-k', ...
        theta, rho(index(5),:)-rho(index(5),1), 'c', ...
        theta, rho(index(6),:)-rho(index(6),1), '--r', ...
        theta, rho(index(7),:)-rho(index(7),1), '--b', ...
        theta, rho(index(8),:)-rho(index(8),1), '--k', ...
        'Style', 'compass', 'Rlimit', [1 -25], 'RTickAngle', 0.001, ...
        'RTickLabel', cellstr(['-20'; '-15';'-10'; ' -5';'  0']), ...
        'RTickValue',[-20 -15 -10 -5 0] ); 
legend('125 Hz','250 Hz', '500 Hz', '1000 Hz', '2000 Hz', '4000 Hz', '8000 Hz', '16000 Hz');
print -depsc KM184_allfreqs


%% e)
% Convert dB values to p values, choose p_0 = 1 arbitrarily

KM184_p = 10.^(KM184(:,2:38)./20); % Convert from dB to SPL
freqs = KM184(:,1);
p_max = zeros(size(KM184_p,1),1);

% find max value for each frequncy
for i= 1:size(KM184_p,1)
    p_max(i) = max(KM184_p(i,:));
end

% directivity factor (take into account only 180 degrees)
gamma = zeros(size(KM184_p,1),1);
area_element = 5/360*2*pi*sum(sin(theta));
for i= 1:size(KM184_p,1)
    num = 37*p_max(i)^2*area_element;
    
    denom = sum(KM184_p(i,:).^2.*area_element) ;
    gamma(i) = num/denom;
end

% directivity measure
loggamma = 10*log10(gamma);

% plot frequency dependant directivity factor
figure;
semilogx(freqs,gamma);
xlabel('Frequenz in Hz');
ylabel('B¸ndelungsgrad');
xlim([freqs(1) freqs(end)]);
print -depsc Buendelungsgrad

% plot frequency dependant directivity index
figure;
semilogx(freqs,loggamma);
xlabel('Frequenz in Hz');
ylabel('B¸ndelungsmaﬂ');
xlim([freqs(1) freqs(end)]);
print -depsc Buendelungsmass





