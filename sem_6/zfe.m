clc;
clear all;
close all;

message = randi([0,1],1,100000);
snr = 0:2:40;
mod = 2;
L = 2; % No. of TAPS
r = 3; % 3 TAP EQUALISER
mod_msg = pskmod(message,mod);

h1 = 1; h2 = 0.7;
H = zeros(r,r+L-1);
for p = 1:r
H(p,p:p+L-1) = [h1 h2];
end

X = mod_msg;
X_1 = circshift(X,1);
X_1(1) = 0;
X1 = circshift(X,-1);
X1(end) = 0;
X2 = circshift(X,-2);
X2(end-1:end)= 0;
x = [X2;X1;X;X_1];

K = H*H';
H_pseudo = inv(inv(K)*K)*inv(K);
C = H_pseudo*H*[0;0;1;0];

ber_wo_ZFE = [];
ber_w_ZFE = [];

for p = 1:length(snr)
        k = [h1 h2]*[X;X_1];
        y = awgn(k,snr(p),'measured');
        Noise = y - k;

        k = [h1 h2]*[X1;X];
        y1 = awgn(k,snr(p),'measured');
        Noise_1 = y1 - k;
       
        k = [h1 h2]*[X2;X1];
        y2 = awgn(k,snr(p),'measured');
        Noise_2 = y2 - k;

                        
        Y = (H*x)+ [Noise_2;Noise_1;Noise];
        X_P = C.'*Y;
        
        demod_w_zfe = pskdemod(X_P',mod);
        demod_wo_zfe = pskdemod(y2',mod);
        
        [number,ratio1] = biterr(message,demod_w_zfe');
        [number2,ratio2] = biterr(message,demod_wo_zfe');
        
        ber_wo_ZFE = [ber_wo_ZFE,ratio2];
        ber_w_ZFE = [ber_w_ZFE,ratio1];
end

semilogy(snr,ber_wo_ZFE)
hold on
semilogy(snr,ber_w_ZFE,'--')
legend('BER WITHOUT ZFE','BER WITH ZFE')
title('Zero Forcing Equaliser - BPSK - Performance')
xlabel('SNR');
ylabel('BER');