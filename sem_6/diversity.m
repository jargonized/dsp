%diversity

clc;
clear all;
close all;


n_sym = 10000;
x_ip = randi([0 1],n_sym,1);
x_mod = pskmod(x_ip,2);
ip_sym = reshape(x_mod, 2, n_sym/2);
h = 1/sqrt(2)*(randn(1,n_sym)+2*i*randn(1,n_sym));
h_sym = reshape(h,2,n_sym/2);

y = zeros(2,n_sym/2);

for i = 1:n_sym/2
    H = [h_sym(1,i) h_sym(2,i); -conj(h_sym(2,i)) -conj(h_sym(1,i))];
    y(: ,i) = H*ip_sym(:,i);
end

rec = awgn(y,1,'measured');
noise = rec - y;
decoded = zeros(2,n_sym/2);
    
for i = 1:n_sym/2
    H = [h_sym(1,i) h_sym(2,i); -conj(h_sym(2,i)) -conj(h_sym(1,i))];
    H_pseudo = inv((inv(H)*H))*inv(H);
    x_p(:,i) = H_pseudo*rec(:,i);
    disp(H_pseudo*noise(:,i));
    decoded(:,i) = x_p(:,i) - H_pseudo*noise(:,i);
end
    
x_out = reshape(decoded,[],1);
x_demod = pskdemod(x_out,2);
ber = length(find(x_demod~=x_ip))/n_sym;
disp(ber);
    


