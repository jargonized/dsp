function score = dtmf_score(xn,hn)
    xn = xn*(2/max(abs(xn)));
    z = filter(hn,1,xn);
    yn = ifft(z);
    disp(yn);
    if maximum(yn) > 0.6
        score = 1;
    else 
        score = 0;
    end
end
