clc;
clear all;


SNR = 1:1:40;
ber_bpsk = zeros(1,40);
ber_qpsk = zeros(1,40);
ber_16qam = zeros(1,40);
ber_64qam = zeros(1,40);

errorRate = comm.ErrorRate;

for j=1:10
    for snr=1:length(SNR)
    
    channel.SNR = SNR(snr);
    
    %bpsk
    reset(errorRate);
    M = 2;
    bs = log2(M);
    x = randi([0 1],1000,1);
    tx= pskmod(x,2);
    rx = awgn(tx,SNR(snr),'measured');
    decoded = pskdemod(rx,2);
    r = errorRate(x,decoded);
    if (r(1)==0) 
        ber_bpsk(snr) = ber_bpsk(snr) + 1e-7;
    else
        ber_bpsk(snr) = ber_bpsk(snr) + r(1);
    end

    
        
    
    %qpsk
    reset(errorRate);
    r = [0 0 0];
    M = 4;
    bs = log2(M);
    x = randi([0 3],1000,1);
    tx= pskmod(x,4);
    rx = awgn(tx,SNR(snr),'measured');
    decoded = pskdemod(rx,4);
    r = errorRate(x,decoded);
    if (r(1)==0) 
        ber_qpsk(snr) = ber_qpsk(snr) + 1e-7;
    else
        ber_qpsk(snr) = ber_qpsk(snr) + r(1);
    end

    %16-QAM
    reset(errorRate);
    r = [0 0 0];
    M = 16;
    bs = log2(M);
    x = randi([0 1],bs*1000,1);
    tx = qammod(x,M,'bin','InputType','bit');
    rx = awgn(tx,SNR(snr),'measured');
    decoded = qamdemod(rx,M,'bin','OutputType','bit');
    r = errorRate(x,decoded);
    if (r(1)==0) 
        ber_16qam(snr) = ber_16qam(snr) + 1e-7;
    else
        ber_16qam(snr) = ber_16qam(snr) + r(1);
    end

    %64-QAM
    reset(errorRate);
    r = [0 0 0];
    M = 64;
    bs = log2(M);
    x = randi([0 1],bs*1000,1);
    tx = qammod(x,M,'bin','InputType','bit');
    rx = awgn(tx,SNR(snr),'measured');
    decoded = qamdemod(rx,M,'bin','OutputType','bit');
    r = errorRate(x,decoded);
    if (r(1)==0) 
        ber_64qam(snr) = ber_64qam(snr) + 1e-7;
    else
        ber_64qam(snr) = ber_64qam(snr) + r(1);
    end
    
   
    end
end

ber_bpsk = ber_bpsk/10;
ber_qpsk = ber_qpsk/10;
ber_16qam = ber_16qam/10;
ber_64qam = ber_64qam/10;

%plots
figure();
semilogy(SNR,ber_bpsk,'r',SNR,ber_qpsk,'b',SNR,ber_16qam,'g',SNR,ber_64qam,'y');
legend('BPSK','QPSK','16-QAM','64-QAM');
title('Bit Error Rate Comparison');
xlabel('SNR(dB)');ylabel('BER');
axis([0 45 1e-7 10]);
grid;




%finding ranges
bpsk_start = find(ber_bpsk==1e-7);
qpsk_start = find(ber_qpsk==1e-7);
qam16_start = find(ber_16qam==1e-7);
qam64_start = find(ber_64qam==1e-7);

bpsk_start = bpsk_start(1);
qpsk_start = qpsk_start(1);
qam16_start = qam16_start(1);
qam64_start = qam64_start(1);

a = [bpsk_start qpsk_start qam16_start qam64_start];

fileID = fopen('Ranges.dat','w');
fwrite(fileID,a,'double');
fclose(fileID);





