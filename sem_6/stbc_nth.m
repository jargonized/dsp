clc;
clear all;


Input = randi([0,1],1,10000);
k11 = reshape(Input,length(Input),1);
k12 = bin2dec(num2str(k11));

bpsk_mod = pskmod(k12,2);
snr = 2:2:40;

H1 =1/sqrt(2)*[randn(1,1) + 1i*randn(1,1)]; 
H2 =1/sqrt(2)*[randn(1,1) + 1i*randn(1,1)];

y = [];
m = [];
Output = [];
Output_without_STBC = [];
q = 1;
noise = [];

for l = 1:length(snr)

    for p = 1:2:(length(Input))-1
        c1 = (H1*bpsk_mod(p,1)) + (H2*bpsk_mod(p+1,1));
        m(p,q) = awgn(c1,snr(l),'measured');
        noise(p,q) = m(p,q) - c1;
        c2 = (-H1*conj(bpsk_mod(p+1,1))) + (H2*conj(bpsk_mod(p,1)));
        m(p+1,q) = awgn(c2,snr(l),'measured');
        noise(p+1,q) = m(p+1,q) - c2;
    end

for r = 1:2:(length(Input))-1
    H = [H1 H2; -conj(H2) conj(H1)];
    H_pseudo = inv(H'*H)*H';
    k = H_pseudo*[m(r,:); conj(m(r+1,:))];
    n_h = H_pseudo*[noise(r,:); conj(noise(r+1,:))];
    y(r:r+1,q) = k-n_h;
    
end

t1 = pskdemod(y,2);
u1 = dec2bin(t1,2);
v1 = rem(u1,2);
Output(l,:) = reshape(t1',1,length(Input));
end
% BER ESTIMATION FOR STBC ALAMOUTI CODING
[number,ratio] = biterr(Output, Input);
semilogy(snr,ratio')
title('Space Time Block Code - Alamouti Coding - Performance')
xlabel('SNR(dB)')
ylabel('BER')
hold on
% WITHOUT STBC
for l = 1:length(snr)
c3 = awgn((H1*bpsk_mod),snr(l),'measured');
t2 = pskdemod(c3,2);
u2 = dec2bin(t2,2);
v2 = rem(u2,2);
Output_without_STBC(l,:) = reshape(t2,1,length(Input));
end
% BER ESTIMATION FOR WITHOUT STBC ALAMOUTI CODING
[number1,ratio1] = biterr(Output_without_STBC, Input);
semilogy(snr,ratio1','--');
legend('WITH STBC','WITHOUT STBC');
