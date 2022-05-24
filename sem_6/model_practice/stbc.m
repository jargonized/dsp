%stbc
clc;
clear
close all;

n_sym = 10000;
x = randi([0 1],n_sym,1);

h = 1/sqrt(2)*(randn(n_sym,1)+2i*randn(n_sym,1));
h_sym = reshape(h,2,n_sym/2);
mod = pskmod(x,2);
tx = reshape(mod,2,n_sym/2);

ber = [];

for j=1:1:40
y = zeros(2,n_sym/2);
for i=1:n_sym/2
    H = [h_sym(1,i) h_sym(2,i); conj(h_sym(2,i)) -conj(h_sym(1,i))];
    rec = H*tx(:,i);
    y(:,i) = rec;
end

rec = awgn(y,j,'measured');
decod = zeros(2,n_sym/2);

for i=1:n_sym/2
    H = [h_sym(1,i) h_sym(2,i); conj(h_sym(2,i)) -conj(h_sym(1,i))];
    H_pseudo = inv(H'*H)*(H');
    k = H_pseudo*rec(:,i);
    decod(:,i) = k;
end

decod = reshape(decod,n_sym,1);
demod = pskdemod(decod,2);
[number,ratio] = biterr(demod,x);
ber(j) = ratio;

end

semilogy(1:1:40,ber);