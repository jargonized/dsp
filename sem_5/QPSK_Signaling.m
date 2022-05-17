%QPSK

clc;
clear all;
close all;

M = 4;
N =1e7;
Nb = log(M)/log(2);

%message signal
bk = randi([0,1],N*Nb,1);
bs = bk; bs(bs==0) = -1;
bo = bs(1:2:end);
be = bs(2:2:end);
xs = bo+i*be;
scatterplot(xs);
figure;

%SNR
SNRdB = [1,4,8,15];
for i = 1:length(SNRdB)
    SNRi = SNRdB(i);
    rn = awgn(xs,SNRi,'measured');
    subplot(3,4,[2*i-1 2*i]);
    plot(real(rn),imag(rn),'b.',bo,be,'ro');
    legend('received','ideal');
    title(['Receiver - QPSK Constellation - SNR = ',num2str(SNRi),'dB']);
    axis([-2 2 -2 2]);
    
    decoded_o = real(rn);
    decoded_e = imag(rn);
    decoded_o( decoded_o>=0) = 1;  decoded_o( decoded_o<0) = 0;
    decoded_e( decoded_e>=0) = 1;  decoded_e( decoded_e<0) = 0;
    decoded = zeros(size(bk));
    decoded(1:2:end) = decoded_o;
    decoded(2:2:end) = decoded_e;
    
    snr = 10^(SNRi/10);
    EbNo = snr/2;
    EbNo_dB(i) = 10*log10(EbNo);
    BER_th(i) = 1/2*erfc(sqrt(EbNo));
    disp(length(find(bk~=decoded)));
    BER(i) = length(find(bk~=decoded))/(N*Nb);



    

    
end

subplot(3,4,[10 11]);
semilogy(EbNo_dB,BER,'r--',EbNo_dB,BER_th,'b*');
grid on;
xlabel('Eb/No (dB)'); ylabel('Bit Error Probability(P_e)');title('BER Performance of QPSK');
legend('BER Simulated','BER Theoretical');
a = [EbNo_dB;BER_th;BER];
axis([-5 20 1e-15 10]);
fileID = fopen('BER_QPSK.dat','w');
fwrite(fileID,a,'double');
fclose(fileID);
