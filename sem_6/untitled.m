%OFDM

bpskmod = comm.PSKModulator(2,0,'BitInput',true);
bpskdemod = comm.PSKDemodulator(2,0,'BitOutput',true);

n_sym = 64^4;
x_ip = randi([0 1],n_sym,1);
tx = bpskmod(x);

N = 64;
t_x = reshape(tx,64,n_sym/64);

for i = 1:n_sym/64

    of = ifft(t_x(i),64);
    rx = awgn(of,1);
    odf(i) = fft(rx,64);

end

odf = reshape(odf,n_sym,1);
decoded = bpskdemod(odf);








