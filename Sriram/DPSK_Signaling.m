%DPSK
clc;
clear all;
close all;

M = 2;
N = 1e7;
Nb = log(M)/log(2);

%message signal
bk = randi([0,1],N*Nb,1);
dpskmod = comm.DPSKModulator(2,pi/2,'BitInput',true);
dpskdemod = comm.DPSKDemodulator(2,pi/2,'BitOutput',true);

xs = dpskmod(bk);
scatterplot(xs);

%SNR
SNRdB = 1:3:15;
for i = 1:length(SNRdB)
    SNRi = SNRdB(i);
    rn = awgn(xs,SNRi,'measured');
    figure;
    plot(real(rn),imag(rn),'b.',real(xs),imag(xs),'ro');
    legend('received','ideal');
    title(['SNR DPSK - Const = ',num2str(SNRi),'dB']);
    axis([-3.5 3.5 -3.5 3.5]);
    
    decoded = dpskdemod(rn);
    snr = 10^(SNRi./10);
    EbNo = snr;
    EbNo_dB(i) = 10*log10(EbNo);
    BER_th(i) = 1/2*exp(-EbNo);
    BER(i) = length(find(bk~=decoded))/N;
   
end

figure;
semilogy(EbNo_dB,BER,'r--',EbNo_dB,BER_th,'b*');
axis([-4 18 10^-7 1]);
grid on;
xlabel('Eb/No(dB)'); ylabel('Bit Error Probability');title('DPSK BER Performance');

a = [EbNo_dB;BER_th;BER];
fileID = fopen('BER_DPSK.dat','w');
fwrite(fileID,a,'double');
fclose(fileID);
