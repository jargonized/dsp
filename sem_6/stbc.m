clc;
clear all;
close all;

errorRate = comm.ErrorRate;


snr = 2:2:40;

n_sym = 10000;
x_ip = randi([0 1],n_sym,1);
tx = pskmod(x_ip,2);
tx_1 = tx;
h = 1/sqrt(2)*(randi([0 10],1,n_sym)+2*i*randi([0 10],1,n_sym));
h_sym = reshape(h,2,n_sym/2);
h = reshape(h,n_sym,1);
y = zeros(2,n_sym/2);
decoded = zeros(2,n_sym/2);
ber = [];ber_wo=[]; ber_wo1 = [];
tx = reshape(tx,2,n_sym/2);

%WITH STBC

for j = 1:length(snr)

for i = 1:n_sym/2
    H = [h_sym(1,i) h_sym(2,i); -conj(h_sym(2,i)) conj(h_sym(1,i))];
    y(: ,i) = H*tx(:,i);
end

rec = awgn(y,snr(j),'measured');
decoded = zeros(2,n_sym/2);
    
for i = 1:n_sym/2
    H = [h_sym(1,i) h_sym(2,i); -conj(h_sym(2,i)) conj(h_sym(1,i))];
    H_pseudo = inv(inv(H)*H)*inv(H);
    x_p(:,i) = H_pseudo*rec(:,i);
    decoded(:,i) = x_p(:,i);
end
     reset(errorRate);
     decoded = reshape(decoded,n_sym,1);
     decod_demod = pskdemod(decoded,2);
     r = errorRate(x_ip,decod_demod);
     ber(j) = r(1);

     %WITHOUT STBC - SPACE DIVERSITY
     
     k = h.*tx_1;
     rx = awgn(k,snr(j),'measured');
     de = pskdemod(rx,2);
     reset(errorRate);
     m = errorRate(x_ip,de);
     ber_wo(j) = m(1);

     %WITHOUT STBC - TIME DIVERSITY

    for i = 1:n_sym/2
        H = [h_sym(1,1) h_sym(1,1); -conj(h_sym(1,1)) conj(h_sym(1,1))];
        y(: ,i) = H*tx(:,i);
    end
    
    rec = awgn(y,snr(j),'measured');
    decoded = zeros(2,n_sym/2);
        
    for i = 1:n_sym/2
        H = [h_sym(1,1) h_sym(1,1); -conj(h_sym(1,1)) conj(h_sym(1,1))];
        %H_pseudo = (inv(H'*H))'*inv(H);
        H_pseudo = inv(inv(H)*H)*inv(H);
        x_p(:,i) = H_pseudo*rec(:,i);
        %x_p(:,i) = H_pseudo*[rec(1,i) ; conj(rec(2,i))];
        decoded(:,i) = x_p(:,i);
    end
         reset(errorRate);
         decoded = reshape(decoded,n_sym,1);
         decod_demod = pskdemod(decoded,2);
         r = errorRate(x_ip,decod_demod);
         ber_wo1(j) = r(1);
  
end

semilogy(snr, ber, '*-' ,snr, ber_wo,'*-', snr, ber_wo1,'*-');
legend('WITH STBC','WITHOUT STBC - SPACE DIVERSITY','WITHOUT STBC - TIME DIVERSITY');






