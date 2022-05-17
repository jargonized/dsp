clc;
clear all;
close all;

%% S-Array and Input Key Array

S = [0:1:255]; 
S_len=length(S);
K = double('Mystery'); 
K_len=length(K);

repeat = fix(S_len/K_len);
incomplete = rem(S_len,K_len);


K_array=[];
for i = 1:repeat
    K_array = [K_array K];
end
for i = 1:incomplete
    K_array = [K_array K(i)];
end

%% Key Scheduling Algorithm

j = 0;
for i =0:255
    j = j+S(i+1)+K_array(i+1);
    j = mod(j,256);
    temp = S(i+1);
    S(i+1)=S(j+1);
    S(j+1)=temp;
end

%% Plaintext Encoding and Pseudorandom Stream Generation Algorithm

PT = double('I love cryptography');
Kstr = [];
j=0;

for i=1:length(PT)
    j = j+S(i+1);
    j = mod(j,256);
    temp = S(i+1);
    S(i+1)=S(j+1);
    S(j+1)=temp;
    t = S(i+1)+S(j+1);
    t = mod(t,256);
    Kstr = [Kstr S(t+1)];
end

%% Encryption

CT = bitxor(Kstr,PT);
char(CT)

%% Decryption

PT = bitxor(Kstr,CT);
char(PT)
