%ofdm

clc;
clear
close all;


N = 64^4;
message = randi ([0 1],N,1);
Ncp = 16;

snr = 1:1:20;

mod = pskmod(message,2);
mess = reshape(mod,64,64^3);
mess = ifft(mess,64);
ymcp = mess(49:64,:);
y = [ymcp ; mess];

ber1 = [];
ber2 = [];

for i=1:length(snr)
    rec = awgn(y,snr(i),'measured');
    y1 = rec(17:80,:);
    decod = fft(y1,64);
    decod = reshape(decod,N,1);
    demod = pskdemod(decod,2);
    [num,ratio] = biterr(message,demod);
    ber1(i) = ratio;
end
semilogy(snr,ber1);

