function [bits,verification_success] = verifyParity(bits,crc_type)
    % checks whether the data responds to parity 
    % bits and returns the data and a validation flag.
    % see 5.1. CRC calculation of TS38.212
    arguments
        bits           % data with parity bits
        crc_type string     % must be "crc<length><?letter>" letter is only necessary crc24_.
    end
    
    % choose length
    switch(crc_type)
        case "crc6"
            N=6;
        case "crc11"
            N=11;
        case "crc16"
            N=16;
        case {"crc24a","crc24b","crc24c"}
            N=24;
        otherwise   
            throw(MException('crcTypeErr',...
                "Invalid crc type. Must be one of {crc6, crc11," + ...
                "crc16, crc24a, crc24b, crc24c}."))
    end
     
    % checking crc (must be zeros)
    [~,crc]=attachParityBits(bits,crc_type,false);
    verification_success=~any(crc);
    % extracting data
    bits=bits(1:end-N);
end

