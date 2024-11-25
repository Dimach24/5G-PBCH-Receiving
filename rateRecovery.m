function bits = rateRecovery(bits)
    bits = bitSelection(bits);
    bits = subBlockDeinterleaving(bits);
end
function out_seq = bitSelection(bits)
    % rateRecovery_bitSelection Procedure of bit selection for reverse 
    % rate matching of PBCH Receiver module [TS 38.212 5.4.1.2]
    arguments
        bits (1,:); % input sequence
    end
    E = 864;    % determined [TS 38.212, 7.1.5]
    N = 512;    % length of output sequence
    K = 56;     % length of output sequence of further polar decoder
    if E >= N
        out_seq(mod(0:(E-1),N)+1) = bits(1:E);
        return
    elseif (K/E) <= (7/16)
        out_seq(1:E+N-E) = bits(1:E);
        return
    end
    out_seq(1:E) = bits(1:E);
end
function out_seq = subBlockDeinterleaving(bits)
    % rateRecovery_subBlockDeinterleaving Procedure of sub-block
    % deinterleaving for reverse rate matching of PBCH receiver 
    % [TS 38.212, 5.4.1.1]
    % J is the matrix of indexes after sub-block interleaving
    arguments
        bits (1,:) % input sequence of bits
    end
    N = 512;
    J = zeros(1,N);
    P = [0 1 2 4 3 5 6 7 8 16 9 17 10 18 11 19 12 20 13 21 14 22 15 ...
          23 24 25 26 28 27 29 30 31];  % interleaving pattern
    i = floor(32*(0:(N-1))/N);
    J(1:N)=P(i+1)*N/32+mod(0:(N-1), N/32);
    out_seq(J(1:N)+1) = bits(1:N);      % main procedure
end
