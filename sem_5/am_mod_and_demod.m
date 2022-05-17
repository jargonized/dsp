%am modulation and demodulation
clc;clear all;close all;
%signals
ka = 0.250;
ac = 5;
am = 7; %1,3,4,7 
fc = 100e3;
fm = 5e3;
fs = 16*fc;
t = 0:1/fs:1000e-3;
m = am*cos(2*pi*fm*t);
c = ac*cos(2*pi*fc*t);

%modulation
s = (1+ka*m).*c; 
mu = ka*am;disp("Modulation Index:%mu");
figure;
subplot(4,1,1);
%annotation('textbox', [0.45, 0.88, 0.1, 0.1], 'String', "Modulation index (mu) = " + mu)
plot(t(1:1000),c(1:1000)); title('Carrier Signal'); xlabel('Time(s)'); ylabel('Amplitude'); axis([0 0.6e-3 -6 6]);
subplot(4,1,2);
plot(t(1:1000),m(1:1000));title('Modulating Signal'); xlabel('Time(s)'); ylabel('Amplitude');axis([0 0.6e-3 -8 8]);
subplot(4,1,3);
plot(t(1:1000),s(1:1000));title('Modulated Signal'); xlabel('Time(s)'); ylabel('Amplitude');
axis([0 0.6e-3 -15 15]);
%demodulation
[yupper,ylower] = envelope(s);
subplot(4,1,4);
%figure;
plot(t(1:1000),yupper(1:1000));title('Demodulated Signal'); xlabel('Time(s)'); ylabel('Amplitude');
axis([0 0.6e-3 -15 15]);
%modulation frequency domain
figure;
[ps,f] = pspectrum(s,fs,'FrequencyResolution',10);
% subplot(5,1,4);
plot(f,10*log10(ps));title('Power Spectrum of the modulated signal'); xlabel('Frequency(Hz)'); ylabel('Power(dB)');
axis([0 200e3 -70 15]);

