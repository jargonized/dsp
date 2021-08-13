% IIR Filter Design
% Butterworth and Chebyshev Type I Filters

clc
clear 
close all

fs = input("Enter the sampling frequency:");
t = 0:1/fs:10;

%Input Signal
f1 = input("Enter frequency of the first component, f1: ");
f2 = input("Enter frequency of the second component, f2: ");
f3 = input("Enter frequency of the third component, f3: ");

x = sin(2*pi*f1*t)+ sin(2*pi*f2*t)+ sin(2*pi*f3*t);
disp("1. Butterworth, 2. Chebyshev Type I");
k = input("Select filter:");
 type = input("1. Bandpass, 2.Band Reject  SELECT:");
 if type == 1
     type = 'bandpass';
 elseif type == 2
     type = 'stop';
 end

switch k
    case 1
       
        %Design Specifications
        rp = input("Enter passband ripple:");
        rs = input("Enter stopband ripple:");
        f1 = input("Enter the first stopband frequency:");
        fL = input("Enter the first passband frequency:");
        fU = input("Enter the second stopband frequency:");
        f2 = input("Enter the second passband frequency:");

        
        w1 = [2*f1/fs, 2*fU/fs];
        w2 = [2*fL/fs, 2*f2/fs];
                
        %Filter Design
        [N, wn] = buttord(w1,w2,rp,rs);
        [b, a] = butter(N,wn,type);
        disp(N); disp(wn); disp(b); disp(a);
        
        %Verification of Filter Design
        y = filtfilt(b,a,x);
        X = fft(x); Y = fft(y);
        m1 = abs(X); m2 = abs(Y);
        subplot(1,2,1);
        w0 = [(0:length(m1)-1)/(length(m1)-1)]*fs;
        stem(w0,m1);
        title('Magnitude spectrum of the input signal');
        xlabel("Frequency(Hz)");
        ylabel("Gain(dB)");
        subplot(1,2,2);
        w3 = [(0:length(m2)-1)/(length(m2)-1)]*fs;
        stem(w3,m2);
        title("Magnitude Spectrum of Output Signal");
        xlabel("Frequency(Hz)");
        ylabel("Gain(dB)");
        figure();
        freqz(b,a);
        
    case 2
        %Design Specifications
        rp = input("Enter passband ripple:");
        rs = input("Enter stopband ripple:");
        f1 = input("Enter the first stopband frequency:");
        fL = input("Enter the first passband frequency:");
        fU = input("Enter the second stopband frequency:");
        f2 = input("Enter the second passband frequency:");

        
        w1 = [2*f1/fs, 2*fU/fs];
        w2 = [2*fL/fs, 2*f2/fs];
        
        %Filter Design
        [N,wn] = cheb1ord(w1,w2,rp,rs);
        [b,a] = cheby1(N,rp,wn,type);
        disp(N); disp(wn); disp(b); disp(a);
        
        %Verification of Filter Design
        y = filtfilt(b,a,x);
        X = fft(x);
        Y = fft(y);
        m1 = abs(X);
        m2 = abs(Y);
        subplot(221);
        w0 = [(0:length(m1)-1)/(length(m1)-1)]*fs;
        stem(w0,m1);
        title('Magnitude spectrum of the input signal');
        xlabel("Frequency(Hz)");
        ylabel("Gain(dB)");
        subplot(222);
        w3 = [(0:length(m2)-1)/(length(m2)-1)]*fs;
        stem(w3,m2);
        title("Magnitude Spectrum of Output Signal");
        xlabel("Frequency(Hz)");
        ylabel("Gain(dB)");
        figure();
        subplot(2,2,3);
        freqz(b,a);
        
end

            
        
        
        
        





