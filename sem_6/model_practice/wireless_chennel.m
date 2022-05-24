%wireless channels

clc;
clear
close all;

fs = 8000;
f1 = 500;
f2 = 2000;

t = 0:1/fs:1-1/fs;

signal1 = 20*exp(complex(0,2*pi*f1*t));
signal2 = 20*exp(complex(0,2*pi*f2*t));

message = signal1+signal2;
delayed = [zeros(1,60) message(1:1:length(message)-60)];
subplot(2,1,1); plot(t(1:1000),message(1:1000));
subplot(2,1,2); plot(t(1:1000),delayed(1:1000));
figure;
freqres = abs(fft(message));
plot(freqres);

h1 = randn+ 1i*randn;
%Slow and Flat
tx = h1.*message;
figure;
freqres = abs(fft(tx));
plot(freqres);

h2 = randn+ 1i*randn;
tx = h1.*message + h2.*delayed;
figure;
freqres = abs(fft(tx));
plot(freqres);

%Fast and Flat
fc = 10;
h = randn(1,length(t))+ 1i*randn(1,length(t));
[b,a] = butter(12, (2*fc/1000));
lpf = filter(b,a,h);
tx = lpf.*message;
figure;
freqres = abs(fft(tx));
plot(freqres);

ht = randn(1,length(t))+ 1i*randn(1,length(t));
[b,a] = butter(12, (2*fc/1000));
lpf1 = filter(b,a,ht);
tx = lpf.*message + lpf1.*delayed;
figure;
freqres = abs(fft(tx));
plot(freqres);



