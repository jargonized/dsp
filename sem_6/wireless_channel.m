clc;
clear all;
close all;

% Sampling Frequency
fs = 4000 ;
% Frequency 1
f1 = 1000;
% Frequency 2
f2 = 800;
ts = 0:(1/fs):1-(1/fs);
signal1 = 20*exp(complex(0,2*pi*f1*ts));
signal2 = 20*exp(complex(0,2*pi*f2*ts));
message = signal1+signal2;

% DELAYING - SPREADING THE SIGNAL
delayed = [zeros(1,60),message(1:length(message)-60)];
subplot(2,1,1);
plot(ts(1:1000),message(1:1000));
title('MESSAGE SIGNAL');
subplot(2,1,2);
plot(ts(1:1000),delayed(1:1000));
title('DELAYED SIGNAL');
freqres = fft(message);
figure;
magnitudeplot = abs(freqres);
plot(ts,magnitudeplot);
title({'Input Signal';'Frequency Response'});
xlabel('Frequency');
ylabel('Amplitude');

%Slow and Flat Fading
h = randn + (i*randn);
y1 = message.*h;
freqres = fft(y1);
figure;
magnitudeplot = abs(fft(y1));
subplot(2,2,1);
plot(1:fs,magnitudeplot(1:fs));
title('Slow and Flat Fading');
xlabel('Frequency');
ylabel('Amplitude');

%Slow and Frequency Selective Fading
h1 = randn + (i*randn);
h2 = randn + (i*randn);
trans2 = (h1.*message) + (h2.*delayed);
magnitudeplot = abs(fft(trans2));
subplot(2,2,2);
plot(1:fs,magnitudeplot);
title('Slow and Frequency Selective Fading');
xlabel('Frequency');
ylabel('Amplitude');

%Fast and Flat Fading
fc = 10;
hs = randn(1,length(ts)) +(i*randn(1,length(ts)));
[b,a] = butter(12,((2*fc)/1000));
lpf = filter(b,a,hs);
trans3 = lpf.*message;
magnitudeplot = abs(fft(trans3));
subplot(2,2,3);
plot(1:fs,magnitudeplot);
title('Fast and Flat Fading');
xlabel('Frequency');
ylabel('Amplitude');

% Fast and Frequency Selective Fading
ht = randn(1,length(ts)) +(i*randn(1,length(ts)));
lpf1 = filter(b,a,ht);
trans4 = (lpf1.*message) +(lpf1.*delayed);
magnitudeplot = abs(fft(trans4));
subplot(2,2,4);
plot(1:fs,magnitudeplot);
title('Fast and Frequency Selective Fading');
xlabel('Frequency');
ylabel('Amplitude');