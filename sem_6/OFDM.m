clc;
clear;
close all;

snr = 1:1:30;
berf=[];

%% Input
N = 64^4;
b = randi([0 1], N, 1);

%% Modulation
ymod = pskmod(b, 2);

%% Reshaping
ymod = reshape(ymod, 64, 64^3);

%% OFDM Symbol Modulation
ym = ifft(ymod, 64);

%% Adding Cyclic Prefix
ymcp = ym(49:64, :);
ymcp = [ymcp; ym];

for i = 1:length(snr)
    yn = awgn(ymcp, snr(i), 'measured');
    yn = yn(17:80, :);
    yd = fft(yn, 64);
    ydemod = reshape(yd, 64^4, 1);
    ydemod = pskdemod(ydemod, 2);
    ber = length(find(b~=ydemod))/N;
    berf(i) = ber;
end

%% Removing Cyclic Prefix

disp(berf);
semilogy(snr,berf,'*-');
title('OFDM - Performance');
xlabel("SNR(dB)"); ylabel("Bit Error Rate (BER)");
axis([0 17 1e-9 10]);
hold on;

berf=[];
ymod = pskmod(b, 4);

%% Reshaping
ymod = reshape(ymod, 64, 64^3);

%% OFDM Symbol Modulation
ym = ifft(ymod, 64);

%% Adding Cyclic Prefix
ymcp = ym(49:64, :);
ymcp = [ymcp; ym];

for i = 1:length(snr)
    yn = awgn(ymcp, snr(i), 'measured');
    yn = yn(17:80, :);
    yd = fft(yn, 64);
    ydemod = reshape(yd, 64^4, 1);
    ydemod = pskdemod(ydemod, 4);
    ber = length(find(b~=ydemod))/N;
    berf(i) = ber;
end

%% Removing Cyclic Prefix

disp(berf);
semilogy(snr,berf,'*-');

hold on;

berf=[];
ymod = qammod(b, 16);

%% Reshaping
ymod = reshape(ymod, 64, 64^3);

%% OFDM Symbol Modulation
ym = ifft(ymod, 64);

%% Adding Cyclic Prefix
ymcp = ym(49:64, :);
ymcp = [ymcp; ym];

for i = 1:length(snr)
    yn = awgn(ymcp, snr(i), 'measured');
    yn = yn(17:80, :);
    yd = fft(yn, 64);
    ydemod = reshape(yd, 64^4, 1);
    ydemod = qamdemod(ydemod, 16);
    ber = length(find(b~=ydemod))/N;
    berf(i) = ber;
end

%% Removing Cyclic Prefix

disp(berf);
semilogy(snr,berf,'*-');

hold on;

berf=[];
ymod = qammod(b, 64);

%% Reshaping
ymod = reshape(ymod, 64, 64^3);

%% OFDM Symbol Modulation
ym = ifft(ymod, 64);

%% Adding Cyclic Prefix
ymcp = ym(49:64, :);
ymcp = [ymcp; ym];

for i = 1:length(snr)
    yn = awgn(ymcp, snr(i), 'measured');
    yn = yn(17:80, :);
    yd = fft(yn, 64);
    ydemod = reshape(yd, 64^4, 1);
    ydemod = qamdemod(ydemod, 64);
    ber = length(find(b~=ydemod))/N;
    berf(i) = ber;
end

%% Removing Cyclic Prefix

disp(berf);
semilogy(snr,berf,'*-');
legend('BPSK','QPSK','16-QAM','64-QAM');

