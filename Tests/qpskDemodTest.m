function tests=qpskDemodTest
    tests = functiontests(localfunctions);
end
function setupOnce(~)
    cd ./../
end

function teardownOnce(~)  
    cd Tests/
end

function sizeTest(tc)
    verifySize(tc,qpskDemodulation(zeros(1,99)),[1,99*2]);
end
function directTest(tc)
    complex_amplitudes  = exp(1j*(0:3)*pi/2+1j*pi/4);
    ref_bits            = [0 0 1 0 1 1 0 1];
    verifyEqual(tc,qpskDemodulation(complex_amplitudes),ref_bits);
end
function degreeStepTest(tc)
    phi = (0.5:1:359.5)/360*2*pi;
    complex_amplitudes = rand(1,360).*exp(1j.*phi);
    ref_bits=[repmat([0 0],1,90),repmat([1 0],1,90),repmat([1 1],1,90),repmat([0 1],1,90)];
    verifyEqual(tc,qpskDemodulation(complex_amplitudes),ref_bits);
end