function signal = dtmf_encode(sequence) %input sequence is given here

freq1 = [697 770 852 941];
freq2 = [1209 1336 1477 1633];
keys = ['1' '2' '3' 'A';'4' '5' '6' 'B';'7' '8' '9' 'C';'*' '0' '#' 'D'];

%sine signal parameters
Amp = 2;
fsampling = 8000;
toneduration = 0.02;
silence = 0.01;
N = 205;%No of DFT samples
ts = linspace(0,toneduration,toneduration*fs);%timevector
n = [];

%Encoding
signal = [];
for i = 1:length(sequence)
    [r,c] = find(keys==sequence(i)); %finds indices of each character from key matrix
    
    dualtone = A*sin(2*pi*freq1(r)*ts) + A*sin(2*pi*freq2(c)*ts);  
    signal = [signal dualtone];
    
    if i~=length(sequence)
        signal = [signal zeros(1,silence*fsampling)];
        n = [n linspace(0,i*silence,silence*fsampling)];
    end
    
end

figure('Name','Encoded Signal');%plotting the DTMF signal
n = [0:length(signal)-1]/fsampling;
plot(n,signal);
title("Encoded Dual Tone Multi Frequency Signal");
xlabel('Time in seconds'); 
ylabel('Amplitude');

end