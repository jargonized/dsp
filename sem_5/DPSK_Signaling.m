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
figure;
%SNR
SNRdB = [1,4,8,15];
for i = 1:length(SNRdB)
    SNRi = SNRdB(i);
    rn = awgn(xs,SNRi,'measured');
    subplot(3,4,[2*i-1 2*i]);
    plot(real(rn),imag(rn),'b.',real(xs),imag(xs),'ro');
    legend('received','ideal');
    title(['Receiver - DPSK Constellation - SNR = ',num2str(SNRi),'dB']);
    axis([-3.5 3.5 -3.5 3.5]);
    
    decoded = dpskdemod(rn);
    snr = 10^(SNRi./10);
    EbNo = snr;
    EbNo_dB(i) = 10*log10(EbNo);
    BER_th(i) = 1/2*exp(-EbNo);
    BER(i) = length(find(bk~=decoded))/N;
   
end

subplot(3,4,[10 11]);
semilogy(EbNo_dB,BER,'r--',EbNo_dB,BER_th,'b*');
grid on;
xlabel('Eb/No (dB)'); ylabel('Bit Error Probability(P_e)');title('BER Performance of DPSK');
legend('BER Simulated','BER Theoretical');
a = [EbNo_dB;BER_th;BER];
axis([-5 20 1e-15 10]);
fileID = fopen('BER_DPSK.dat','w');
fwrite(fileID,a,'double');
fclose(fileID);
