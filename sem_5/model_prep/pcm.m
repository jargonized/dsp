%pulse code modulation
%line coding
%error correcting - hamming code
%digital modulation
%spread spectrum

%PCM
clc; clear all; close all;
fm = 2e3; fs = 1024*fm; am = 3;
n = [1,2,3,15];
t = 0:1/fs:2/fm;
x = am*cos(2*pi*fm*t);
x_power = x*x';
snr = zeros(1,length(n));
snr_th = zeros(1,length(n));

for i=1:length(n)
    
    delta = 2*am/(2^n(i) - 1);
    partition = -am+delta/2:delta:am-delta/2;
    codebook = -am:delta:am;
    [index,xq] = quantiz(x,partition,codebook);
    subplot(length(n),1,i);
    plot(t,x,'b',t,xq,'r--');
    xq_error = x - xq;
    xq_error_power = xq_error*xq_error';
    snr(i) = 10*log10(x_power / xq_error_power);
    snr_th(i) = 6*n(i) + 1.72;
   

end

     
figure;
plot(n,snr,'b',n,snr_th,'r-*');