clc;
close all;
x=randi([0 1],1,4096);
snr=0:30;
biterror=[];
for i =1:4
 y=pskmod(x,2^i);
 if(i==3)
 y=qammod(x,2^(i+1));
 end
 if(i==4)
 y=qammod(x,2^(i+2));
 end
 p=reshape(y,64,64);
 q=ifft(p,64);
 qm = q(49:64,:); 
 q = [qm;q];
 s=reshape(q,1,height(q)*width(q));
 be=[];
 for j=0:1:30
 h=1/sqrt(rand(1,1)+i*sqrt(rand(1,1)));
 r=h*s;
 n=awgn(r,j,'measured');
 m=inv(h)*n;
 p11=reshape(m,80,64);
 p11 = p11(17:80,:);
 q11=fft(p11,64);
 s11=reshape(q11,1,4096);
 y11=pskdemod(s11,2^i);
 if(i==3)
 y11=qamdemod(s11,2^(i+1));
 end
 if(i==4)
 y11=qamdemod(s11,2^(i+2));
 end
 [num1,e1]=symerr(y11,x);
 be=[be e1];
 end
 biterror(i,:)=be;
end
semilogy(snr, biterror(1,:),'*-k','linewidth',2);hold on;
semilogy(snr, biterror(2,:),'*--m','linewidth',2);hold on;
semilogy(snr, biterror(3,:),'*--y','linewidth',2);hold on;
semilogy(snr, biterror(4,:),'*-c','linewidth',2);hold on;
xlabel('SNR(dB)');
ylabel('BER');
title('SNR VS BER PLOT');
legend('bpsk','qpsk','16qam','64qam');