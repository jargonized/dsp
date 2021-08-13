function codem = dtmf_decode(signal)
    keys = ['1' '2' '3' 'A';'4' '5' '6' 'B';'7' '8' '9' 'C';'*' '0' '#' 'D'];
    fsampling = 8000;
    toneduration = 0.02;
    silence = 0.01;
    l = toneduration*fsampling; %no.of samples per subband
    g = silence*fs; %no. of zeros required to get silence tone
    start = 1; endd = l; 
    len=length(signal); 
    codem = '';
    ampthreshhold =80;
    ki = [18 20 22 24 31 34 38 42];
    N = 205;%no of DFT samples
    
    while start<len
        xn = signal(start:end); %sub band sampling
        start = start + l + g;
        endd= endd + g + l;
        f = [];
        for m=1:8
            f(m) = gfft(xn,N,k(m)); 
        end
            
        val = abs(f);
        figure();
        stem(ki,val);
        title("Filtered Data");
        ylabel("Magnitude");
        xlabel("Frequency bin value");
        
       
 %decoding
        for s =1:4
            if val(s) > ampthreshhold
               break
            end
        end
        
        for o = 5:8
            if val(o)>ampthreshhold
                break
            end
        end
        
        codem = strcat(codem,keys(s,o-4));
        
    end
    
end