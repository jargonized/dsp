clc
clear all;
close all;

seq = input("Enter the sequence",'s');
f1 = [697 770 852 941];
f2 = [1209 1336 1477 1633];
keys = ['1' '2' '3' 'A';'4' '5' '6' 'B';'7' '8' '9' 'C';'*' '0' '#' 'D'];
f = [697 770 852 941 1209 1336 1477 1633];

%sine signal parameters
A = 0.5;
fs = 8000;
toneduration = 0.04;
silence = 0.01;
ts = linspace(0,toneduration,toneduration*fs);

%Encoding
signal = [];
for i = 1:length(seq)
    [r,c] = find(keys==seq(i));
    dual_tone = A*sin(2*pi*f1(r)*ts) + A*sin(2*pi*f2(c)*ts);  
    signal = [signal dual_tone];
    signal = [signal zeros(1,silence*fs)];
end









l = toneduration*fs; %no.of samples per subband in the signal vector
    m = silence*fs; %no. of zeros used to generate silence tone
    N = 64; %order of the filter
    N1=N+1;
    if(mod(N,2))==0 
        N1=N;
        N=N-1;
    end

    %FIR Filter Bank    
    w = rectwin(N1);
    b = [];
    for i=1:8
        b1 = fir1(N,[f(i)-20 f(i)+20]/fs,'bandpass',w);
        freqz(b1);
        hold ON
        b = [b b1];
    end
    
    %Computing the impulse response
    
    %extracting the subbands of the signal and applying the filter to find
    %the tone frequencies
    
    beg = 1; endl = l; k=length(signal); p = length(b); codem = '';
    while endl<k
        xn = signal(beg:endl);
        beg = beg + l + m;
        endl = endl + m + l;
        i=1; e=0; fq = [];
        while i<p
            h = b(i:i+63);
            e = e+1;
            xn = xn*(2/max(abs(xn)));
            z = filter(h,1,xn);
            disp(max(z));
            disp(fq);
    
            if max(z) > 0.6
                score = 1;
            else 
                score = 0;
            end
            
            if (score == 1)
                fq = [fq f(e)];
            end
            
            disp(fq);
            
            i = i+64;
            disp(i);
            
            
        end
        
        r1 = find(f1==fq(1));
        c1 = find(f1==fq(2))-4;
        strcat(keys(r1,c1));
        disp(codem);
   
    end