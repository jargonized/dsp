clc;
clear all;
close all;

Rb = 1e3; Nb = 1000;
PN = [1 0 0 1 0 1 1];
len_PN = length(PN);
Rc = Rb*len_PN;
OSRC = 4;
OSRB = OSRC * len_PN;
fs = OSRB*Rb;

b = randi([0,1],Nb,1);
b(b==0) = -1;
PN(PN==0)=-1;


pulse_b = ones(1,OSRB);
pulse_c = ones(1,OSRC);

bit_seq = zeros(1,(Nb-1)*OSRB+1);
bit_seq(1:OSRB:end) = b;
bit_seq = conv(bit_seq,pulse_b);

chip_seq = zeros(1,(len_PN-1)*OSRC+1);
chip_seq(1:OSRC:end) = PN;
chip_seq = conv(chip_seq,pulse_c);

tb = (0:OSRB*Nb-1)/(OSRB*Rb);
tc = (0:OSRC*len_PN-1)/(OSRC*Rc);

subplot(4,1,1);plot(tb,bit_seq);
subplot(4,1,2);plot(tc,chip_seq);

pn = [];
for i=1:Nb
    pn = [pn chip_seq];
end

x = bit_seq.*pn;
[px,fx] = pwelch(bit_seq,[],[],[],fs);
[pa,fa] = pwelch(x,[],[],[],fs);

subplot(4,1,3);plot(fx,10*log10(px));
subplot(4,1,4);plot(fa,10*log10(pa));
