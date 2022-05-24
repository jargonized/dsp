%rc4

clc;
clear all;
close all;

S = 1:1:256;
Slen = length(S);
K = double('KEY');
Klen = length(K);

%Matching the length of K and S

Karr = [];

full = fix(Slen/Klen);
ind = rem(Slen,Klen);

for i=1:full
    Karr = [Karr K];
end

for i=1:ind
    Karr = [Karr K(i)];
end

%Key Scheduling Algorithm

j=0;
for i=0:255
    j = j+S(i+1)+Karr(i+1);
    j = mod(j,256);
    temp = S(i+1);
    S(i+1) = S(j+1);
    S(j+1) = temp;
end

%Stream Generation

PT = double('I love cryptography');
Kstr = [];
j =0;

for i=1:length(PT)
    j = j+S(i+1);
    j = mod(j,256);
    temp = S(i+1);
    S(i+1) = S(j+1);
    S(j+1) = temp;
    t = S(i+1) + S(j+1);
    t = mod(t,256);
    Kstr = [Kstr S(t+1)];
end

CT = bitxor(Kstr,PT);
disp(char(CT));

DT = bitxor(Kstr,CT);
disp(char(DT));
