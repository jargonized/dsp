%Design of FIR Filters

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

disp('1. Rectangular 2.Blackmann 3.Hanning 4.Hamming'); 
k = input('Select Window type:');
disp('1.Lowpass 2.Highpass 3.Bandpass 4.Band Reject');
m = input('Select Filter Type');




switch m
    case 1
        m = 'low';
        N=input('Enter the order of the filter:'); 
        N1=N+1;
        if(mod(N,2))==0 
            N1=N;
            N=N-1;
        end
        wp=input('Enter the cutoff frequency:');
        wc=(2*wp)/fs;
    case 2
        m = 'high';
        N=input('Enter the order of the filter:'); 
        N1=N+1;
        if(mod(N,2))~=0 
            N1=N;
            N=N-1;
        end
        wp=input('Enter the cutoff frequency:');
        wc=(2*wp)/fs;
    case 3
        m = 'bandpass';
        N=input('Enter the order of the filter:'); 
        N1=N+1;
        if(mod(N,2))==0 
            N1=N;
            N=N-1;
        end
        wp1=input('Enter First cutoff frequency'); 
        wp2=input('Enter Second cutoff frequency');
        wc=[(2.*wp1)/fs (2.*wp2)/fs];
    case 4
        m = 'stop';
        N=input('Enter the order of the filter:'); 
        N1=N+1;
        if(mod(N,2))~=0 
            N1=N;
            N=N-1;
        end
        wp1=input('Enter First cutoff frequency: '); 
        wp2=input('Enter Second cutoff frequency: ');
        wc=[(2.*wp1)/fs (2.*wp2)/fs];
end
       
switch k
    case 1
        y = rectwin(N1);
    case 2
        y = blackman(N1);
    case 3
        y = hanning(N1);
    case 4
        y = hamming(N1);
end


b=fir1(N,wc,m,y); 
X=fft(x); 
z=filter(b,1,x); 
disp(b);
Z=fft(z); 
m1=abs(X);
m2=abs(Z);
subplot(121);
w0=[(0:length(m1)-1)/(length(m1)-1)]*fs; 
stem(w0,m1);
xlabel('Frequency(Hz)'); 
ylabel('Gain');
title('Magnitude spectrum of Input Signal');
subplot(122);
w3=[(0:length(m2)-1)/(length(m2)-1)]*fs; 
stem(w3,m2);
xlabel('Frequency(Hz)'); 
ylabel('Gain');
title('Magnitude spectrum of Filtered Signal'); 
figure();
freqz(b);       
    
    
        
        