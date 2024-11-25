function [bits] = descramblePbch(bits,NCellId, Lmax_, ibarSsb_lsb)
    % THIS PROCEDURE IS EQUAL TO SCRAMBLING PROCEDURE 
    % [deprecated]
    % DescrambleProcedure of revererse scrambling
    % after demodulation [7.3.3.1, TS 38.211]
    
    arguments
        bits (1,:)          % input sequence (boolean matrix)
        NCellId (1,1)
        Lmax_ (1,1)         % maximum number of 
                            % candidate SS/PBCH blocks in 
                            % half frame [5, TS 38.213]
        ibarSsb_lsb (1,1)   % candidate SS/PBCH block index
    end
    M = 864; % length of generated PBCH bit sequence
    c = pseudoRandomSequence(NCellId,M*Lmax_); % sequence for PBCH scrambling
    bits(1:M) = mod(bits(1:M)+ c((1:M)+ibarSsb_lsb*M),2); % iSSB = nu
end

