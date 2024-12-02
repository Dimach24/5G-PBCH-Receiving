function tests=crcTest
    tests = functiontests(localfunctions);
end
function setupOnce(~)
    cd ./../
end

function teardownOnce(~)  
    cd Tests/
end

function positiveTest(tc)
    cfg=crcConfig("Polynomial",'z^24 + z^23 + z^21 + z^20 + z^17 + z^15 + z^13 + z^12 + z^8 + z^4 + z^2 + z^1 + z^0');
    for i=1:100
        ref=randi([0,1], 1, 100,'logical');
        data=crcGenerate(ref.',cfg).';
        [data,flag]=verifyParity(data,'crc24c');
        verifyTrue(tc,flag);
        verifyEqual(tc,data,ref);
    end
end

function negativeTest(tc)
    cfg=crcConfig("Polynomial",'z^24 + z^23 + z^21 + z^20 + z^17 + z^15 + z^13 + z^12 + z^8 + z^4 + z^2 + z^1 + z^0');
    for i=1:100
        ref=randi([0,1], 1, 100,'logical');
        data=crcGenerate(ref.',cfg).';
        bit_to_beat=randi(length(data));
        data(bit_to_beat)=1-data(bit_to_beat);
        [~,flag]=verifyParity(data,'crc24c');
        verifyFalse(tc,flag);
    end
end