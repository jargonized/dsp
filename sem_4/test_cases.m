% %Define number of samples to take
% fs = 8000;
% f = 400; %Hz
% %Define signal
% t = 0:1/fs:1-1/fs;
% signal = sin(2*pi*f*t);
% %Plot to illustrate that it is a sine wave
% plot(t, signal);
% title('Time-Domain signal');
% %Take fourier transform
% fftSignal = fft(signal);
% %apply fftshift to put it in the form we are used to (see documentation)
% fftSignal = fftshift(fftSignal);
% %Next, calculate the frequency axis, which is defined by the sampling rate
% f = fs/2*linspace(-1,1,fs);
% %Since the signal is complex, we need to plot the magnitude to get it to
% %look right, so we use abs (absolute value)
% figure;
% plot(f, abs(fftSignal));
% title('magnitude FFT of sine');
% xlabel('Frequency (Hz)');
% ylabel('magnitude');


samples = length(ts);
for i = 1:1:length(t)
    for n = 1:1:samples
        x1reconstructed(i) = x1reconstructed(i) + x1resampled(n)*sinc((t(i)-n*Ts)/Ts); %%% CHANGE
    end
end