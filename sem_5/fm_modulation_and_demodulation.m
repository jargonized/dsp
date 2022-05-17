%am modulation and demodulation
clc;clear all;close all;

%signals
kf = 10e3;
ac = 1.5;
am = 0.25; %0,0.025,0.5,1.75,3.5
fc = 200e3;
fm = 500;
fs = 16*fc;
t = 0:1/fs:1000e-3;
m = am*cos(2*pi*fm*t);
c = ac*cos(2*pi*fc*t);

%modulation
delf = kf*am;
beta = delf/fm;
s = ac*cos( (2*pi*fc*t) + (beta*sin(2*pi*fm*t)) ); 


%modulation frequency domain
[ps,f] = pspectrum(s,fs,'FrequencyResolution',10);
figure;
plot(f/1e3, 10*log10(ps));title('Power Spectrum of the modulated signal'); xlabel('Frequency(Hz)'); ylabel('Power(dB)');
axis([180 220 -70 10]); grid on;

%received signal
y = s;

%demodulation
mout = fmdemod(y,fc,fs,kf*am+10e-9);

%plots
figure;
subplot(5,1,1);
annotation('textbox', [0.45, 0.88, 0.1, 0.1], 'String', "Modulation index (beta) = " + beta)
plot(t(1:1000),c(1:1000)); title('Carrier Signal'); xlabel('Time(s)'); ylabel('Amplitude');
subplot(5,1,2);
plot(t(1:5000),m(1:5000));title('Modulating Signal'); xlabel('Time(s)'); ylabel('Amplitude');
subplot(5,1,3);
plot(t(1:1000),s(1:1000));title('Modulated Signal'); xlabel('Time(s)'); ylabel('Amplitude');
subplot(5,1,4);
plot(t(1:1000),y(1:1000));title('Received Signal'); xlabel('Time(s)'); ylabel('Amplitude');
subplot(5,1,5);
plot(t(2000:5000),mout(2000:5000));title('Demodulated Signal'); xlabel('Time(s)'); ylabel('Amplitude');
 