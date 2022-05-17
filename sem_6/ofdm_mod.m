clc;
clear;
close all;

snr = 1:1:30;

%% Input
N = 64^4;

b1 = randi([0 1], N, 1);


ymod1 = pskmod(b1, 2);
ymod2 = pskmod(b1, 4);
ymod3 = qammod(b1, 16);
ymod4 = qammod(b1, 64);


[berf1]=ofdm1(ymod1,b1,1);
[berf2]=ofdm1(ymod2,b1,2);
[berf3]=ofdm1(ymod3,b1,3);
[berf4]=ofdm1(ymod4,b1,4);

semilogy(snr,berf1,'b*-');
hold on;
semilogy(snr,berf2,'r*-');
hold on;
semilogy(snr,berf3,'m*-');
hold on;
semilogy(snr,berf4,'g*-');
title('OFDM - Performance');
xlabel("SNR(dB)"); ylabel("Bit Error Rate (BER)");
axis([0 30 1e-9 10]);
legend('BPSK','QPSK','16QAM','64QAM');


function [ber] = ofdm1(ymod,b,y)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
snr = 1:1:30;
ber = [];
N = 64^4;
ymod = reshape(ymod, 64, 64^3);
ym = ifft(ymod, 64);
ymcp = ym(49:64, :);
ymcp = [ymcp; ym];

for i = 1:length(snr)
    yn = awgn(ymcp, snr(i), 'measured');
    yn = yn(17:80, :);
    yd = fft(yn, 64);
    ydemod = reshape(yd, 64^4, 1);
    if y==1
        ydemod = pskdemod(ydemod, 2);
    elseif y==2
        ydemod = pskdemod(ydemod, 4);
    elseif y==3
        ydemod = qamdemod(ydemod, 16);
    elseif y==4
        ydemod = qamdemod(ydemod, 64);
    end
        
    ber(i) = length(find(b~=ydemod))/N;
end

end
