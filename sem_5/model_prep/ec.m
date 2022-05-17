clc;
clear all;
close all;

N = 1e7;
k =4;
n=7;
Nb = N*k;

P = [1 1 0; 0 1 1; 1 1 1; 1 0 1];
G = [P eye(k)];
H = [eye(n-k) P'];
E = [0 0 0 0 0 0 0; 1 0 0 0 0 0 0; 0 1 0 0 0 0 0; 0 0 1 0 0 0 0; 0 0 0 1 0 0 0; 0 0 0 0 1 0 0; 0 0 0 0 0 1 0; 0 0 0 0 0 0 1];
syn = E*H';

synbin = dec2bin(syn');
synbin = reshape(synbin, n-k, 2^(n-k));
syndec = bin2dec(synbin');

b = randi([0,1],Nb,1);
m = reshape(b,N,k);
m = mod(m*G,2);
x = reshape(m,N*n,1);
x(x==0) = -1;

EbNodB = 1:1:4;

for i=1:length(EbNodB)
    %without coder
    snr = 3.01 + EbNodB(i);
    rn = awgn(x,snr,'measured');
    rn(rn>=0) = 1; rn(rn<0) = 0;
    rn = reshape(rn,N,n);
    BERWO(i) = sum(sum(rn~=m))/(N*n);

    %with coder
    snr = 3.01+EbNodB(i)+10*log10(4/7);
    rn = awgn(x,snr,'measured');
    rn(rn>=0) = 1; rn(rn<0) = 0;

    rn = reshape(rn,N,n);
    syn = mod(rn*H',2);
    synbin = dec2bin(syn');
    synbin = reshape(synbin, n-k, N);
    synval = bin2dec(synbin');

    for j = 1:N
        ei(j) = find(synval(j)==syndec);
    end

    Ei = E(ei,: );
    corrected = mod(rn+Ei,2);
    corrected = corrected(:, n-k+1:end);
    corrected = reshape(corrected,Nb,1);
    BERW(i) = length(find(corrected~=b))/(Nb);
    
end

EbNo = 10 .^ (EbNodB/10);
BER = 1/2*erfc(sqrt(EbNo));
semilogy(EbNodB,BERWO,'b-',EbNodB,BERW,'m-',EbNodB,BER,'r*');
axis([0 15 10e-8 1]);

