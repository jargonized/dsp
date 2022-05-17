%BPSK
clc;
clear all;
close all;

M = 2;
N = 1e7;
Nb = log(M)/log(2);

%message signal
bk = randi([0,1],N*Nb,1);
xs = bk; xs(xs==0) = -1;
scatterplot(xs);

%SNR
SNRdB = 1:3:15;
for i = 1:length(SNRdB)
    SNRi = SNRdB(i);
    rn = awgn(xs,SNRi,'measured');
    figure;
    plot(real(rn),imag(rn),'b.',xs,imag(bk),'ro');
    legend('received','ideal');
    title(['SNR BPSK Const = ',num2str(SNRi),'dB']);
    axis([-5.5 5.5 -1.5 1.5]);
    
    decoded = real(rn);  decoded( decoded>=0) = 1;  decoded( decoded<0) = 0;
    snr = 10^(SNRi./10);
    EbNo = snr/2;
    EbNo_dB(i) = 10*log10(EbNo);
    BER_th(i) = 1/2*erfc(sqrt(EbNo));
    BER(i) = length(find(bk~=decoded))/N;
    
end

figure;
semilogy(EbNo_dB,BER,'r--',EbNo_dB,BER_th,'b*');
axis([-4 18 10^-7 1]);
grid on;
xlabel('Eb/No(dB)'); ylabel('Bit Error Probability');title('BPSK BER Performance');

a = [EbNo_dB;BER_th;BER];
fileID = fopen('BER_BPSK.dat','w');
fwrite(fileID,a,'double');
fclose(fileID);

