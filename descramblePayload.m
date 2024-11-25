function out_seq = descramblePayload(bits,NCellId,Lmax_)
    % THIS PROCEDURE IS EQUAL TO SCRAMBLING PROCEDURE 
    % [deprecated]
    % descrambling Procedure of scrambling
    % before CRC attachment [7.1.2, TS 38.212] 
    arguments
        bits (1,:) % input sequence (boolean matrix)
        NCellId (1,1) % cell ID
        Lmax_ (1,1) % maximum number of candidate SS/PBCH blocks in half frame [4.1, TS 38.213]
    end
    
    %init
    A = length(bits);
    s = zeros(1,A);
    M = A-3 - (Lmax_ == 10) - 2*(Lmax_ == 20) - 3*(Lmax_ == 64);
    nu = [bits(1+6) bits(1+24)]; % 3rd & 2nd LSB of SFN are stored in 
    nu = bit2int(nu.',2);       % bits 6 & 24 of interleaved sequence

    %determination of c
    c = pseudoRandomSequence(NCellId,160);

    %determination of s
    i = 0;
    j = 0;
    while i < A
        s_null_cond = i == 6 || i == 24 || ...
        i == 0 || (i == 2)&&(Lmax_ == 10) || ...
        ((i == 2)||(i == 3))&&(Lmax_ == 20) || ...
        ((i == 2)||(i == 3)||(i == 5))&&(Lmax_ == 64);
        if  ~s_null_cond
            s(1+i) = c(1+j+nu*M);
            j = j+1;
        else
            s(1+i) = 0;
        end
        i = i+1;
    end

    %scrambling procedure
    out_seq = zeros (1,A);
    for i = 1:A
        out_seq(i) = mod(bits(i)+ s(i),2);
    end
end

