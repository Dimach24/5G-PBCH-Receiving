function out_seq = deinterleavePayload(bits)
    % deinterleavePayload process of reverse interleaving before
    % MIB extraction [7.1.1, TS 38.212]
    
    arguments
        bits (1,:) % sequence of bits
    end

    % initializing
    K = length(bits);
    out_seq = zeros(1,length(bits));
    % Pattern defined in the table 7.1.1-1 of TS 38.212 
    INTERLEAVING_PATTERN = [16 23 18 17 8 30 10 6 24 7 0 5 3 2 1 4 ...
    9 11 12 13 14 15 19 20 21 22 25 26 27 28 29 31]; 
    
    % main procedure
    for i = 1:K
        out_seq(i) = bits(INTERLEAVING_PATTERN(i)+1);
    end
    
    % required additional sorting
    copy_seq = zeros(1,K);
    copy_seq(1) = out_seq(15);          % choice bit
    copy_seq(2:7) = out_seq(1:6);       % MSB of SFN 6 bits
    copy_seq(8:24) = out_seq(16:32);    % bits from SCS to spare bit
    copy_seq(25:28) = out_seq(7:10);    % LSB of SFN 4 bits
    copy_seq(29) = out_seq(11);         % HRF bit
    copy_seq(30:32) = out_seq(12:14);   % kssb 3 bits
    out_seq = copy_seq;
end

