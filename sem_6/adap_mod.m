clc;
clear all;
close all;

fileID = fopen('Ranges.dat','r');
a = fread(fileID,'double');
fclose(fileID);

bound = 40;

errorRate = comm.ErrorRate;

SNR=10:1:40;
err=zeros(size(SNR));
for i=1:length(SNR)
    
    channel.SNR = SNR(i);

    if(a(1)<=SNR(i)<a(2))
        
        %BPSK
        M = 2;
        bs = log2(M);
        x = randi([0 1],bs*1000,1);
        tx= pskmod(x,2);
        rx = awgn(tx,SNR(i),'measured');
        decoded = pskdemod(rx,2);
               
    elseif(a(2)<=SNR(i)<a(3))
        
        %QPSK
        M = 4;
        bs = log2(M);
        x = randi([0 3],1000,1);
        tx= pskmod(x,4);
        rx = awgn(tx,SNR(i),'measured');
        decoded = pskdemod(rx,4);
    
    elseif(a(3)<=SNR(i)<a(4))
        
        %16-QAM
        M = 16;
        bs = log2(M);
        x = randi([0 1],bs*1000,1);
        tx = qammod(x,M,'bin','InputType','bit');
        rx = awgn(tx,SNR(i),'measured');
        decoded = qamdemod(rx,M,'bin','OutputType','bit');
    
    elseif(a(4)<=SNR(i)<=bound)
        
        %64-QAM
        M = 64;
        bs = log2(M);
        x = randi([0 1],bs*1000,1);
        tx = qammod(x,M,'bin','InputType','bit');
        rx = awgn(tx,SNR(i),'measured');
        decoded = qamdemod(rx,M,'bin','OutputType','bit');
    
    end
    r = [0 0 0];
    reset(errorRate);
    r = errorRate(x,decoded);
    if (r(1)==0) 
        err(i) = 1e-7;
    else
        err(i) = r(1);
    end
end    

figure;
semilogy(SNR,err);
title('Bit Error Rate - Adaptive Modulation');
xlabel('SNR(dB)');ylabel('Bit Error Rate');