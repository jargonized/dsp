clc;
clear all;
close all;

Rb = 1e3;
Nb = 10000;
b = randi([0 1],Nb,1);
b(b==0) = -1;
PN = [1 0 1 0 1 1 0 0];
len_PN = length(PN);
Rc = Rb * len_PN;
OSRc = 4;
OSRb = OSRc * len_PN;

fs = OSRb*Rb;
pulse_c = ones(1,OSRc);
pulse_b = ones(1,OSRb);

bit_seq = zeros(1,(Nb-1)*OSRb+1);
bit_seq(1:OSRb:end) = b;
bit_seq = conv(bit_seq,pulse_b);
tb = (0:Nb*OSRb-1)/(Rb*OSRb);
subplot(3,1,1);
plot(tb,bit_seq);title('Message Signal');xlabel('Time(s)');ylabel('Amplitude');

PN(PN==0) = -1;
chip_seq = zeros(1,(len_PN - 1)*OSRc +1);
chip_seq(1:OSRc:end) = PN;
chip_seq = conv(chip_seq,pulse_c);
tc = (0:len_PN*OSRc - 1)/(Rc*OSRc);
subplot(3,1,2);
plot(tc,chip_seq); title('Pseudorandom Noise (PRN) Signal');xlabel('Time(s)');ylabel('Amplitude');

pn = [];
for i=1:Nb
    pn = [pn chip_seq];
end
xs = pn.*bit_seq;
subplot(3,1,3);
plot(tb,xs); title('DSSS - BPSK Signal');xlabel('Time(s)');ylabel('Amplitude'); 

[pb,fb] = pwelch(bit_seq,[],[],[],fs);
[px,fx] = pwelch(xs,[],[],[],fs);

figure;
subplot(2,1,1);plot(fb,10*log10(pb));title('Frequency Spectrum of the Message Signal');xlabel('Frequency(Hz)');ylabel('Power(dB)');
subplot(2,1,2);plot(fx,10*log10(px));title('Frequency Spectrum of the Spreaded Signal');xlabel('Frequency(Hz)');ylabel('Power(dB)');



