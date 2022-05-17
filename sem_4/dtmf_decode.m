%DECODER

function codem = dtmf_decode(signal)

    %Constants Declaration
    
    keys = ['1' '2' '3' 'A';'4' '5' '6' 'B';'7' '8' '9' 'C';'*' '0' '#' 'D'];
    fs = 8000;
    toneduration = 0.02;
    silence = 0.01;
    l = toneduration*fs; %no.of samples per subband in the signal vector
    g = silence*fs; %no. of zeros used to generate silence tone
    beg = 1; endl = l; 
    p=length(signal); 
    codem = '';
    threshold =80;
    k = [18 20 22 24 31 34 38 42];
    N = 205;
    
    while beg<p
        xn = signal(beg:endl); %subband sampling
        beg = beg + l + g;
        endl = endl + g + l;
        f = [];
        for m=1:8
            f(m) = gfft(xn,N,k(m)); %filtering
        end
            
        val = abs(f);
        figure();
        stem(k,val);
        title("Transformed Data");
        xlabel("Frequency bin value");ylabel("Magnitude");
        
       
        %decoding
        for s =1:4
            if val(s) > threshold
               break
            end
        end
        
        for o = 5:8
            if val(o)>threshold
                break
            end
        end
        
        codem = strcat(codem,keys(s,o-4));
        
    end
    
end
