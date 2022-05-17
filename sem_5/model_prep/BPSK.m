clc;
clear all;
close all;

N=1e7;
M = 2;
Nb = log(M)/log(2);

b = randi([0,1],Nb*N,1);
dpskmod = comm.DPSKModulator(2,pi/2,'BitInput',true);
dpskdemod = comm.DPSKDemodulator(2,pi/2,'BitOutput',true);

xs = dpskmod(b);
scatterplot(xs);title('Transmitter - QPSK');xlabel('In-phase');ylabel('Quadrature');

SNR = 1:3:15;
for i = 1:length(SNR)
    snri = SNR(i);
    rn=awgn(xs,snri,'measured');
    figure;
    plot(real(rn),imag(rn),'b.',real(xs),imag(xs),'ro');
    decoded = dpskdemod(rn);

    snr = 10^(snri/10);
    EbNo = snr;
    EbNodB(i) = 10*log10(EbNo);
    BER_th(i) = 1/2*exp(-EbNo);
    BER(i) = length(find(decoded~=b))/(N*Nb);

end
figure;
semilogy(EbNodB,BER_th,'b*',EbNodB,BER,'r--');