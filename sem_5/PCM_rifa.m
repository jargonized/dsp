clc;
clear all;
close all;

SNR_cal = []; SNR_th = [];

%MESSAGE SIGNAL
fm = 2e3;
fs = 1000*fm;
Am = 3;
t = 0:(1/fs):(3/fm);
x = Am*cos(2*pi*fm*(t+0.25e-3));
%POWER OF INPUT SIGNAL
x_p = x*x';

n = 1:15; %No.of bits

for i=(1:length(n))
    a = n(i);
    del = (2*Am)/((2^a)-1); %Step size
    boundary = -Am+(del/2) : del : Am-(del/2); %partitions to which a sample can be assigned
    codebook = -Am : del : Am; %Quantised values

    %QUANTISED SIGNAL
    [ind,xq] = quantiz(x,boundary,codebook);

    figure; plot(t,x,'b-',t,xq,'r--'); title("Quantisation - n = ",num2str(a)); 
    xlabel("time(s)"); ylabel("Amplitude"); legend('Original signal','Quantised signal');
    axis([0 max(t)+0.1e-3 min(x)-0.3 max(x)+0.3]);

    e = x-xq;
    xq_p = e*e';
    SNR = (x_p)/(xq_p); SNR_cal(i) = 10*log10(SNR);
    SNR_th(i) = 6*a + 1.72;
end

figure; plot(n,SNR_cal,'b-',n,SNR_th,'r--'); title('COMPARISON OF SNR FOR DIFFERENT NO.OF BITS');
xlabel('No.of bits'); ylabel('SNR'); legend('Calculated','Theoretical');
   