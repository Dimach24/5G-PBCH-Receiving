function [bits] = qpskDemodulation(complex_amplitudes)
    % demodulates QPSK complex amplitudes vector to bitstream
    bits=zeros(1,length(complex_amplitudes)*2);
    for i=1:length(complex_amplitudes)
        bits(2*i-1)=(1-sign(real(complex_amplitudes(i))))/2;
        bits(2*i)=(1-sign(imag(complex_amplitudes(i))))/2;
    end
    bits=floor(bits);
end

