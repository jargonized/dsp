% IIR Filter Design
% Butterworth and Chebyshev Type I Filters
% Lowpass and Highpass Filters

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
 type = input("1. Lowpass, 2.Highpass 3.Bandpass 4.BandReject SELECT:");
 if type == 1
     type = 'low';
 elseif type == 2
     type = 'high';
 elseif type == 3
     type = 'bandpass';
 elseif type == 4
     type = 'stop';
 end
 
 if (type == "low" || type== "high")
     %Design Specifications
        rp = input("Enter passband ripple:");
        rs = input("Enter stopband ripple:");
        fp = input("Enter passband frequency");
        fr = input("Enter stopband frequency");
        wp = (2*pi*fp)./fs;
        ws = (2*pi*fr)./fs;
       
        w1 = (2*tan(wp/2)).*(fs);
        w2 = (2*tan(ws/2)).*(fs);
        
 
 elseif (type == "bandpass" || type== "stop")
      %Design Specifications
        rp = input("Enter passband ripple:");
        rs = input("Enter stopband ripple:");
        f1 = input("Enter the first stopband frequency:");
        fL = input("Enter the first passband frequency:");
        fU = input("Enter the second stopband frequency:");
        f2 = input("Enter the second passband frequency:");
        
        wp =2*pi*f1./fs;
        wl =2*pi*fL./fs;
        wu =2*pi*fU./fs;
        ws =2*pi*f2./fs;
        
        W1 = 2*tan(wp/2).*fs;
        WL = 2*tan(wl/2).*fs;
        WU = 2*tan(wu/2).*fs;
        W2 = 2*tan(ws/2).*fs;

        
        w1 = [W1, WU];
        w2 = [WL, W2];
 end
   
 switch k
    case 1
             
        %Filter Design
        [N, wn] = buttord(w1,w2,rp,rs,'s');
        [b, a] = butter(N,wn,type,'s');
        [b1, a1] = bilinear(b,a,fs);
        
        
 
    case 2
       
        
        %Filter Design
        [N,wn] = cheb1ord(w1,w2,rp,rs,'s');
        [b,a] = cheby1(N,rp,wn,type,'s');
        [b1, a1] = bilinear(b,a,fs);
        
        
     case 3
         
        %Filter Design
        [N, wn] = buttord(w1,w2,rp,rs,'s');
        [b, a] = butter(N,wn,type,'s');
        [b1, a1] = bilinear(b,a,fs);
  
     case 4
         
        %Filter Design
        [N,wn] = cheb1ord(w1,w2,rp,rs,'s');
        [b,a] = cheby1(N,rp,wn,type,'s');
        [b1, a1] = bilinear(b,a,fs);
  
 end

 %Verification of Filter Design
 disp(N); disp(wn); disp(b); disp(a);
 y = filtfilt(b1,a1,x);
 X = fft(x);
 Y = fft(y);
 m1 = abs(X);
 m2 = abs(Y);
 subplot(1,2,1);
 w0 = [(0:length(m1)-1)/(length(m1)-1)]*fs;
 stem(w0,m1);
 title('Magnitude spectrum of the input signal');
 xlabel("Frequency(Hz)");
 ylabel("Gain(dB)");
 subplot(122);
 w3 = [(0:length(m2)-1)/(length(m2)-1)]*fs;
 stem(w3,m2);
 title("Magnitude Spectrum of Output Signal");
 xlabel("Frequency(Hz)");
 ylabel("Gain(dB)");
 figure();
 freqz(b1,a1);

            
        
        
        
        





