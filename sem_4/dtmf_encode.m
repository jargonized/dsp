%ENCODER

function signal = dtmf_encode(seq)

%Key to map the tones
f1 = [697 770 852 941];
f2 = [1209 1336 1477 1633];
keys = ['1' '2' '3' 'A';'4' '5' '6' 'B';'7' '8' '9' 'C';'*' '0' '#' 'D'];

%sine signal parameters
A = 2;
fs = 8000;
toneduration = 0.02;
silence = 0.01;
N = 205;
ts = linspace(0,toneduration,toneduration*fs);


%Encoding
signal = [];
for i = 1:length(seq)
    if ~any(keys(:) == seq(i))
        disp('Invalid Input,allowed characters are 1234567890*#ABCD');
        return;
    end
    
    
    [r,c] = find(keys==seq(i));
    
    dual_tone = A*sin(2*pi*f1(r)*ts) + A*sin(2*pi*f2(c)*ts);  
    signal = [signal dual_tone];
    
    if i~=length(seq)
        signal = [signal zeros(1,silence*fs)];
       
    end
    
end

figure('Name','Encoded Signal');
n = [0:length(signal)-1]/fs;
plot(n,signal);
title("Encoded Dual Tone Multi Frequency Signal");
xlabel('Time(s)'); ylabel('Amplitude');

end







    
    
    
   








    
    
    
