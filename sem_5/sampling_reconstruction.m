clc; clear all; close all;
f0 = 2000; fm = f0; fs = 4000;                                                                                                                                                                                             
delf = f0/20;

T0 = 1/f0;
Ts = 1/fs;

order = 6; A=2;
Fsdash = 8*fs;


D = 25/100;

T1 = (1/Fsdash)*D;

N0 = Fsdash/fs;
N1 = round(N0*D);

t = -T0/2:1/Fsdash:5000*T0;
N = length(t);

x = 2+A*cos(2*pi*fm*t);
pulse = [ones(1,N1) zeros(1,N0-N1)];
deltrain = zeros(1,N-N0+1);
deltrain(1:N0:end)=1;
p=conv(deltrain,pulse);
v=p.*x;

[b,a] = butter(order,fm/(Fsdash/2));
[H,w]= freqz(b,a,Fsdash,Fsdash);
y=filter(b,a,v);

figure;

subplot(4,1,1); plot(t,x); xlabel('Time(s)'); ylabel('Amplitude'); axis([min(t) max(t) min(x) max(x)]);title('Message Signal');
subplot(4,1,2); plot(t,p); xlabel('Time(s)'); ylabel('Amplitude'); axis([min(t) max(t) min(p) max(p)]);title('Pulse Train Signal');
subplot(4,1,3); plot(t,v); xlabel('Time(s)'); ylabel('Amplitude'); axis([min(t) max(t) min(v) max(v)]);title('Sampled Signal');
subplot(4,1,4); plot(t,y); xlabel('Time(s)'); ylabel('Amplitude'); axis([min(t) max(t) min(y) max(y)]);title('Reconstructed Signal');

[px, fx] = pspectrum(x,Fsdash,'FrequencyResolution',delf);
[pv, fv] = pspectrum(v,Fsdash,'FrequencyResolution',delf);
[py, fy] = pspectrum(y,Fsdash,'FrequencyResolution',delf);


figure;

subplot(4,1,1); plot(fx,10*log10(px)); xlabel('Frequency(Hz)'); ylabel('Power(dB)'); axis([-1 4*fs -50 max(10*log10(px)+1)]);title('Power Spectrum of Message Signal');
subplot(4,1,2); plot(w, 10*log10(abs(H))); xlabel('Frequency(Hz)'); ylabel('Magnitude');axis([-1 4*fs -50 max(abs(H)+1)]); title('Filter Response');
subplot(4,1,3); plot(fv,10*log10(pv)); xlabel('Frequency(Hz)'); ylabel('Power(dB)'); axis([-1 5*fs -50 max(10*log10(pv)+1)]);title('Power Spectrum of Sampled Signal');
subplot(4,1,4); plot(fy,10*log10(py)); xlabel('Frequency(Hz)'); ylabel('Power(dB)'); axis([-1 5*fs -100 max(10*log10(py)+1)]);title('Power Spectrum of Reconstructed Signal');


