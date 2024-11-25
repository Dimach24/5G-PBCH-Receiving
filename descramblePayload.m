function out_seq = descramblePayload(bits,NCellId,Lmax_)
    % THIS PROCEDURE IS EQUAL TO SCRAMBLING PROCEDURE 
    % [deprecated]
    
    % descrambling Procedure of revererse scrambling
    % after CRC detachment [7.1.2, TS 38.212] 
    arguments
        bits (1,:)      % input sequence
        NCellId (1,1)   % cell ID
        Lmax_ (1,1)     % maximum number of candidate SS/PBCH 
                        % blocks in half frame [4.1, TS 38.213]
    end
    
    % init
    A = length(bits);
    s = zeros(1,A);
    M = A-3 - (Lmax_ == 10) - 2*(Lmax_ == 20) - 3*(Lmax_ == 64);
    % 3rd & 2nd LSB of SFN are stored in 
    % bits 6 & 24 of interleaved sequence
    nu = [bits(1+6) bits(1+24)]; 
    nu = bin2dec(num2str(nu));       

    % determination of c
    x1 = zeros(1,2000);
    x2 = zeros(1,2000);
    x1(1) = 1;
    x1(2:31) = 0;
    x2(1:31) = fliplr(dec2bin(NCellId,31)); % c_init = N_Cell_ID
    for n = 1:2000
        x1(n+31) = mod(x1(n+3)+x1(n),2);
        x2(n+31) = mod(x2(n+3)+x2(n+2)+x2(n+1)+x2(n),2);
        n1 = 1:160;
        c(n1) = mod(x1(n1+1600)+x2(n1+1600),2);
    end

    % determination of s
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

    % descrambling procedure
    out_seq = zeros (1,A);
    for i = 1:A
        out_seq(i) = mod(bits(i)+ s(i),2);
    end
end

