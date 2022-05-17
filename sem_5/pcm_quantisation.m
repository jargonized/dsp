clc;
clear all;
close all;

fm = 1e3;
fs = 1024*fm;
Am =2 ;
n = 1:3;

t = 0: 1/fs:2/fm;
x = Am*cos(2*pi*fm*t);
x_power = x*x';
SQNRdb = zeros(1,length(n));
SQNRdb_th = zeros(1,length(n));


for i = 1:length(n)
    delta = 2*Am/(2^n(i)-1);
    partition = -Am+delta/2:delta:Am-delta/2;
    codebook = -Am:delta:Am;
    
    [index,xq] = quantiz(x,partition,codebook);
    qe = x - xq;
    qe_avg = mean(qe);
    qe_power = qe*qe';
    SQNR = x_power/qe_power;
    SQNRdb(i) = 10*log10(SQNR);
    SQNRdb_th(i) = 6*n(i) + 1.72;
    subplot(3,1,i);
    
    plot(t,x,'r-',t,xq,'b--');title('Time Domain Signal',i);axis([0 2e-3 -3 3]);
    xlabel('Time(s)');
    ylabel('Amplitude');
    legend('Message Signal','Quantized Signal');
end

    delta = 2*Am/(2^15-1);
    partition = -Am+delta/2:delta:Am-delta/2;
    codebook = -Am:delta:Am;
    
    [index,xq] = quantiz(x,partition,codebook);
    qe = x - xq;
    qe_avg = mean(qe);
    qe_power = qe*qe';
    SQNR = x_power/qe_power;
    SQNRdb(4) = 10*log10(SQNR);
    SQNRdb_th(4) = 6*15 + 1.72;
    figure;
    plot(t,x,'r-',t,xq,'b--');title('Time Domain Signal',15);
    xlabel('Time(s)');
    ylabel('Amplitude');
    legend('Message Signal','Quantized Signal');



figure;
k = [1,2,3,15];
plot(k, SQNRdb,'r-',k,SQNRdb_th,'b-*'); 
title('Signal-to-Quantization-Noise Ratio');
xlabel('Index(i)');
ylabel('Power(dB)');
legend('SQNR','SQNR Theoretical');


    
